-- Insert時, jj でNormalへ
vim.keymap.set("i", "jj", "<Esc>", { silent = true, desc = "Insertモード解除" })

-- Insert時, Ctrl+hjkl で移動
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "左へ" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "下へ" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "上へ" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "右へ" })

-- 画面分割後の画面間移動設定
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "左ウィンドウへ" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { desc = "下ウィンドウへ" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { desc = "上ウィンドウへ" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "右ウィンドウへ" })

-- Tabでのインデントの増減
vim.keymap.set("n", "<Tab>", ">>", { desc = "右インデント" })
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "左インデント" })
vim.keymap.set("v", "<Tab>", "<S->>", { desc = "右インデント" })
vim.keymap.set("v", "<S-Tab>", "<S-<>", { desc = "左インデント" })

-- ESC連打でハイライト解除
vim.keymap.set("n", "<Esc><Esc>", "<cmd>:nohlsearch<cr>", { desc = "ハイライト解除" })

-- バッファの移動
vim.keymap.set("n", "<C-h>", "<cmd>:bprev<cr>", { desc = "前バッファ" })
vim.keymap.set("n", "<C-j>", "<cmd>:bnext<cr>", { desc = "次バッファ" })
vim.keymap.set("n", "<C-k>", "<cmd>:bprev<cr>", { desc = "前バッファ" })
vim.keymap.set("n", "<C-l>", "<cmd>:bnext<cr>", { desc = "次バッファ" })

vim.keymap.set('n', '<leader>m', function()
  local view = vim.fn.winsaveview()

  vim.cmd([[%s/。\ze./. /ge]])
  vim.cmd([[%s/。$/. /ge]])
  vim.cmd([[%s/、/, /ge]])
  vim.cmd([[%s/\S\zs\s*$/  /ge]])

  vim.cmd('noh')
  vim.fn.winrestview(view)
end, { desc = 'Format text for markdown' })
