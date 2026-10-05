"""Exercise the installer without installing packages or touching user settings."""

import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

MACOS = Path(__file__).resolve().parents[1]
PROFILES = ["desktop", "cloud", "vpn", "optional"]


class BootstrapTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="brew tests ")
        self.addCleanup(self.temp.cleanup)
        self.work = Path(self.temp.name)
        self.bin = self.work / "bin"
        self.bin.mkdir()
        self.log = self.work / "calls"
        self.env_log = self.work / "environment"
        self.env = {
            key: value for key, value in os.environ.items()
            if not key.startswith("HOMEBREW_")
        }
        self.env.update({
            "PATH": f"{self.bin}{os.pathsep}{os.defpath}",
            "TEST_LOG": str(self.log),
            "TEST_ENV_LOG": str(self.env_log),
        })
        self.write_command("uname", '#!/bin/bash\nprintf "%s\\n" "${TEST_OS:-Darwin}"\n')
        self.write_command("brew", r'''#!/bin/bash
{
  printf '%s\t' "$@"
  printf '\n'
} >> "$TEST_LOG"
printf '%s\t%s\t%s\t%s\t%s\t%s\n' \
  "${HOMEBREW_BUNDLE_NO_UPGRADE-}" "${HOMEBREW_NO_INSTALL_UPGRADE-}" \
  "${HOMEBREW_BUNDLE_INSTALL_CLEANUP-}" "${HOMEBREW_NO_INSTALL_CLEANUP-}" \
  "${HOMEBREW_NO_AUTO_UPDATE-}" "${HOMEBREW_NO_ANALYTICS-}" >> "$TEST_ENV_LOG"
if [[ "${TEST_FAIL_COMMAND:-}" == "$1" ]]; then exit 9; fi
''')

    def write_command(self, name, content):
        path = self.bin / name
        path.write_text(content)
        path.chmod(0o755)

    def invoke(self, *args, script=None):
        return subprocess.run(
            ["/bin/bash", str(script or MACOS / "brew.sh"), *args],
            env=self.env, cwd=self.work, text=True, capture_output=True,
            timeout=15,
        )

    def calls(self):
        if not self.log.exists():
            return []
        return [line.rstrip("\t").split("\t") for line in self.log.read_text().splitlines()]

    def assert_profiles(self, calls, profiles, action="install", directory=MACOS):
        names = ["Brewfile"] + [f"Brewfile.{profile}" for profile in profiles]
        expected = [] if action == "check" else [["analytics", "off"]]
        if action == "upgrade":
            expected.append(["update"])
        for name in names:
            args = ["bundle", action, f"--file={directory / name}"]
            if action != "upgrade":
                args.append("--no-upgrade")
            if action == "check":
                args.append("--verbose")
            expected.append(args)
        self.assertEqual(calls, expected)

    def test_default_installs_core_without_upgrades(self):
        result = self.invoke()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assert_profiles(self.calls(), [])
        self.assertEqual(set(self.env_log.read_text().splitlines()), {"1\t1\t\t1\t\t1"})

    def test_selected_profiles_are_additive(self):
        result = self.invoke("install", "--cloud", "--desktop")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assert_profiles(self.calls(), ["desktop", "cloud"])

    def test_all_and_duplicate_flags_install_each_profile_once(self):
        result = self.invoke("--desktop", "--all", "--cloud", "--all")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assert_profiles(self.calls(), PROFILES)

    def test_each_profile_can_be_selected_independently(self):
        for profile in PROFILES:
            with self.subTest(profile=profile):
                self.log.write_text("")
                result = self.invoke(f"--{profile}")
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assert_profiles(self.calls(), [profile])

    def test_check_does_not_install_upgrade_or_refresh(self):
        result = self.invoke("check", "--all")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assert_profiles(self.calls(), PROFILES, action="check")
        self.assertEqual(set(self.env_log.read_text().splitlines()), {"1\t1\t\t1\t1\t1"})

    def test_upgrade_is_explicit_and_limited_to_selected_profiles(self):
        self.env.update(HOMEBREW_BUNDLE_NO_UPGRADE="1", HOMEBREW_NO_INSTALL_UPGRADE="1")
        result = self.invoke("upgrade", "--cloud")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assert_profiles(self.calls(), ["cloud"], action="upgrade")
        self.assertEqual(set(self.env_log.read_text().splitlines()), {"\t\t\t1\t\t1"})

    def test_inherited_cleanup_is_disabled(self):
        self.env["HOMEBREW_BUNDLE_INSTALL_CLEANUP"] = "1"
        result = self.invoke("--desktop")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(set(self.env_log.read_text().splitlines()), {"1\t1\t\t1\t\t1"})

    def test_help_has_no_homebrew_or_platform_requirement(self):
        (self.bin / "brew").unlink()
        self.env["TEST_OS"] = "Linux"
        result = self.invoke("--help")
        self.assertEqual(result.returncode, 0)
        self.assertIn("Usage:", result.stdout)
        self.assertEqual(self.calls(), [])

    def test_unknown_argument_fails_before_homebrew(self):
        result = self.invoke("--desktop", "--typo")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Unknown argument", result.stderr)
        self.assertEqual(self.calls(), [])

    def test_non_macos_fails_before_homebrew(self):
        self.env["TEST_OS"] = "Linux"
        result = self.invoke()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("macOS only", result.stderr)
        self.assertEqual(self.calls(), [])

    def test_missing_homebrew_has_actionable_error(self):
        (self.bin / "brew").unlink()
        self.env["PATH"] = str(self.bin)
        result = self.invoke()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Install Homebrew", result.stderr)

    def test_update_failure_stops_before_bundle(self):
        self.env["TEST_FAIL_COMMAND"] = "update"
        result = self.invoke("upgrade", "--all")
        self.assertEqual(result.returncode, 9)
        self.assertEqual(self.calls(), [["analytics", "off"], ["update"]])

    def test_bundle_failure_stops_before_later_profiles(self):
        self.env["TEST_FAIL_COMMAND"] = "bundle"
        result = self.invoke("--all")
        self.assertEqual(result.returncode, 9)
        self.assert_profiles(self.calls(), [])

    def test_missing_check_dependency_returns_failure(self):
        self.env["TEST_FAIL_COMMAND"] = "bundle"
        result = self.invoke("check")
        self.assertEqual(result.returncode, 9)
        self.assert_profiles(self.calls(), [], action="check")

    def test_paths_with_spaces_and_unrelated_working_directory(self):
        directory = self.work / "checkout with spaces" / "macos"
        shutil.copytree(MACOS, directory, ignore=shutil.ignore_patterns("__pycache__"))
        result = self.invoke("--desktop", script=directory / "brew.sh")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assert_profiles(self.calls(), ["desktop"], directory=directory)

    def test_all_manifests_are_checked_before_installation(self):
        directory = self.work / "incomplete checkout"
        directory.mkdir()
        shutil.copy(MACOS / "brew.sh", directory)
        shutil.copy(MACOS / "Brewfile", directory)
        result = self.invoke("--desktop", script=directory / "brew.sh")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Cannot read", result.stderr)
        self.assertEqual(self.calls(), [])


class ManifestTests(unittest.TestCase):
    def test_shell_syntax(self):
        subprocess.run(["/bin/bash", "-n", str(MACOS / "brew.sh")], check=True)

    def test_brewfile_declarations(self):
        # Evaluate the actual Ruby DSL with no Homebrew or network dependency.
        ruby = r'''
require "json"
class Manifest
  attr_reader :entries
  def initialize
    @entries = []
  end
  [:brew, :cask, :tap].each do |kind|
    define_method(kind) { |name| @entries << [kind.to_s, name] }
  end
end
puts JSON.generate(ARGV.to_h do |file|
  manifest = Manifest.new
  manifest.instance_eval(File.read(file), file)
  [File.basename(file), manifest.entries]
end)
'''
        result = subprocess.run(
            ["ruby", "-e", ruby, *map(str, sorted(MACOS.glob("Brewfile*")))],
            check=True, capture_output=True, text=True,
        )
        manifests = json.loads(result.stdout)
        self.assertEqual(set(manifests), {"Brewfile", *[f"Brewfile.{p}" for p in PROFILES]})
        core = manifests["Brewfile"]
        self.assertTrue(all(kind == "brew" for kind, _ in core))
        for name in ["fzf", "fd", "bat", "eza", "zoxide", "gh", "uv", "k9s", "go", "kubernetes-cli"]:
            self.assertIn(["brew", name], core)
        entries = [tuple(entry) for values in manifests.values() for entry in values]
        self.assertEqual(len(entries), len(set(entries)), "Duplicate package declarations")
        for name in ["nvm", "rust", "docker", "google-cloud-sdk", "font-noto-nerd"]:
            self.assertNotIn(("brew", name), entries)
        self.assertNotIn(("cask", "go"), entries)
        for name in ["docker-desktop", "gcloud-cli", "ngrok", "xiaoxiaosn/xiaoxiao/font-noto-nerd"]:
            self.assertIn(("cask", name), entries)
        for name in ["lens", "postman", "another-redis-desktop-manager", "google-chrome"]:
            self.assertIn(["cask", name], manifests["Brewfile.optional"])


if __name__ == "__main__":
    unittest.main()
