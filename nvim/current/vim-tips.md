# Vim Tips

## 基本操作

### 移動你的游標

- `w`, `W` 往前到下一個字的字首，`e`, `E` 下一個字的字尾
- `b`, `B` 往回到前一個字的字首
- `$` 跳到行尾
- `0` 跳到行首，`^` 跳到該行第一個文字（不算 TAB 或是空白）
- **`{`, `}` 往前/後跳一個段落**
- **`f` 之後按任意字元，跳到該行下一個的那個字元**
- **`C_o` 跳回上一個遊標的位置， `C_i` 跳到下一個**
- `C_d` 向下滾動，`C_u` 向上滾動
- **`*` 搜尋並前往下一個目前遊標上的字，`:noh` 取消**
- `#` 搜尋並前往上一個目前遊標上的字，`:noh` 取消

### 複製貼上

- `p` 往後貼上，`P` 往游標前貼上
- **`u` 是 undo, `C_r` 再 Redo 回去**
- 也可以用 `"` 然後 `a`~`z` 來指定暫存器，例如 `"ay` 複製 `"ap` 貼上
- `d` 是剪下，`x` 可以剪下遊標上的那一個字
- `c` 可以刪除選取並原地進入插入模式，`C` 刪除該行以後並進入插入模式
- `>>` `<<` 可以縮排該行

## 寫字囉

- `i` 插入模式 `I` 在該行第一個字進入插入模式
- `a` 在遊標後面進入插入模式 **`A` 在行末進入插入模式**
- `o` 向下產生新一行進入插入模式 `O` 向上
- **`s` substitute 代替，剪下遊標上的字並進入插入模式**
- `r` 取代一個字元
- 插入模式下的操作
  - `C-w` 刪除遊標往回的一個字
  - `C-u` 刪除遊標往回的所有字
  - Note: 在 Bash 下很多操作也通用喔 https://github.com/tpope/vim-rsi
- 在檔案取代 `%s` `%s/foo/bar/gc` `g` 是全部、`c` 是確認

## 比剛剛更會移動

### 標記模式

- `m{a-zA-Z}` 按一下 `m` 加上英文字就可以在那個字上標籤
- `'{a-zA-Z}` 單引號加上標籤就飛過去那一行囉
- `` `{a-zA-Z} `` 單引號加上標籤就飛過去標記的字囉
- 上面兩個也可以組合刪除，`d'a` 就是刪除刪到 `'a` 的地方
- 刪掉他 `delm aA` delete mark a and A

### Window 視窗

- `:sp` `:split` 或是 `C-w s`，水平、上下分割你的視窗
- `:vs` `:vsplit` 或是 `C-w v` 垂直、左右分割你的視窗
- `C-w` + `hjkl` 或是上下左右，移動目前 focus 的視窗位置
- `:q` 或是 `C-w q` 退出

## 選取大師

- 選取技能之排列組合
  - 動作類型：
    - `v` visual 選取
    - `d` delete 剪下
    - `c` change 剪下後插入
    - `y` yank 複製
  - 範圍： `i` inner 選取物件條件 `a` around 包含選取條件
  - 名詞條件：
    - `w` word
    - `s` sentence
    - `p` paragraph
    - `t` tag (HTML, XML tags)
    - `'"` 引號
    - `)]}>` 括號
- `viw` 選取遊標上的字 i=inner w=word
- **`ciw` 同上剪下遊標上的字並進入插入模式**
- `vi"` 選取 `"` 中間的字，`'` 也可以
- `va"` 差別是會包含雙引號 a=around

### 你的 Buffer

- `:ls` 查看分頁內的 buffer 們
  ```
  :ls
  4  h   "plugin-config.vim"            line 3
  5 %a   "prelude.vim"                  line 50
  6  h   "[No Name]"                    line 1
  7 #h   "init.vim"                     line 5
  Press ENTER or type command to continue
  ```
- 切換分頁
  - `:b` + `數字` 可以切換到指定 Buffer，例如 `:b4`
  - `:b` + `部分檔案名` 也可以切換，例如 `:b init`
  - `:bn` go next buffer
  - `:bp` go previous buffer
  - `:bl` go last
  - `:bf` go first
- `:bd` delete buffer

## Others

- 按下 `:` 後可以輸入指令，例如 `:echo hello`
- 查看/複製曾經使用的 Commands，可以用 `q:`，底下會跳出 window 顯示指令歷史。
  `:q` 或是 `C-w q` 退出

### 想看 key mapping

你是不是設定了很多 key mapping 但忘記了呀？

```
:map
```

或是想指定模式也可以

```
:nmap for normal mode mappings
:vmap for visual mode mappings
:imap for insert mode mappings
```

輸出出來看的方法

```
:redir! > vim_keys.txt
:silent verbose map
:redir END
```

ref: https://stackoverflow.com/a/15756785
