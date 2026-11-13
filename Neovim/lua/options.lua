-- エンコーディング設定
vim.scriptencoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"

-- ファイル設定
vim.opt.swapfile = false
vim.opt.backup = false

-- カラーテーマ
vim.opt.background = 'dark'

-- スペースキーを Leader キーに設定
vim.g.mapleader = " "

-- 行番号をon
vim.opt.number = true

-- タブのスペース変換をon
vim.opt.expandtab = true

-- タブ幅を4にする
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- スマートインデントをon
vim.opt.smartindent = true
vim.opt.autoindent = true

-- スペースなどの見た目を変更│┃
vim.opt.list = true
vim.opt.listchars = { tab = "│ ", trail = "-", eol = "↵" }

-- 行末+1までカーソル移動可能
vim.opt.virtualedit = "onemore"

-- マウス操作をoff
vim.opt.mouse = "n"

-- 折り返しをon
vim.opt.wrap = true

-- 行のハイライトをon
vim.opt.cursorline = true

-- 検索ワードのハイライトをon
vim.opt.hlsearch = true

-- ファイル更新時の自動更新をon
vim.opt.autoread = true

-- 大文字小文字関係なく検索する
vim.opt.ignorecase = true
-- 大文字が入っていたらそのとおり検索する
vim.opt.smartcase = true

-- カーソル移動時のカッコ強調(matchparen)を無効化(重いため)
vim.g.loaded_matchparen = 1

-- ファイルタイプ検出、プラグイン、インデントを有効化
vim.cmd("filetype plugin on")

-- Neovimのシステムクリップボードを有効化
vim.opt.clipboard:append("unnamedplus")

-- コマンドプロンプトを利用
if vim.fn.has("win32") == 1 then
    vim.opt.shell = "cmd.exe"
    vim.opt.shellcmdflag = "/s /c"
end
