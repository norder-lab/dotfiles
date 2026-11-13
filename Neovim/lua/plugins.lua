-- lazy.nvim(プラグインマネージャ)の自動インストール
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- ここにお気に入りのプラグインを追加していく

    -- nordic テーマ --
    {
        "rmehri01/onenord.nvim",
        lazy = false,
        priority = 1000,

        config = function()
            require("onenord").setup()
            vim.cmd.colorscheme("onenord")
        end,
    },

    -- Nord テーマ --
    -- {
    --     "shaunsingh/nord.nvim",
    --     lazy = false,    -- 起動時にすぐ読み込む
    --     priority = 1000,
    --     config = function()
    --         -- テーマを有効化
    --         vim.g.nord_borders = true
    --         vim.g.nord_bold = false
    --         vim.cmd("colorscheme nord")
    --     end,
    -- },

    -- ステータスラインの装飾
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = { theme = 'onenord' } -- ステータスラインもOneNord
            })
        end
    },

    -- カッコの自動補完
    {
        'echasnovski/mini.pairs',
        version = '*',
        opts = {
            skip_next = [=[%w%%%'%"%`%.%]%}%>]=],
        },
        config = function()
            require('mini.pairs').setup()
        end
    },

    -- visual mode 時、選択した文字列の両脇に()などを挿入
    {
        "NStefan002/visual-surround.nvim",
        config = function()
            require("visual-surround").setup({})
        end,
    },

    -- Markdownの箇条書き自動継続 ＆ リスト編集プラグイン (bullets.vim)
    {
        "gaoDean/autolist.nvim",
        ft = { "markdown" },
        config = function()
            local autolist = require("autolist")
            autolist.setup({
                colon = {
                    indent = false,
                    indent_raw = false,
                },
            })

            local map = vim.keymap.set
            -- Enterやo/Oで次の箇条書き・チェックボックスを自動生成
            map("i", "<CR>", "<CR><cmd>AutolistNewBullet<CR>")
            map("n", "o", "o<cmd>AutolistNewBullet<CR>")
            map("n", "O", "O<cmd>AutolistNewBulletBefore<CR>")

            -- ノーマルモードでチェックボックスのトグル（[ ] ↔ [x]）
            map("n", "<Leader>x", "<cmd>AutolistToggleCheckbox<CR>")

            -- 行削除やインデント変更時に番号を自動再計算
            map("n", "dd", "dd<cmd>AutolistRecalculate<CR>")
        end,
    },

    -- インデントの可視化
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },

    -- キーマップ表示
    {
        "nvim-mini/mini.clue",
        version = false,
        config = function()
            local clue = require("mini.clue")

            clue.setup({
                triggers = {
                    { mode = "n", keys = "<Leader>" },
                    { mode = "x", keys = "<Leader>" },
                },
                window = {
                    delay = 100,
                },
            })
        end,
    },

    -- Todoなどの強調と一覧化(TODO, FIX, NOTE, HACK(仮実装), WARN, TEST)
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            highlight = {
                keyword = "fg",
            },
        },

        config = function(_, opts)
            require("todo-comments").setup(opts)
            vim.keymap.set("n", "<leader>tp", "<cmd>TodoQuickFix<cr>", { desc = "Todo QuickFix", })
            vim.keymap.set("n", "<leader>tl", "<cmd>TodoLocList<cr>", { desc = "Todo LocList", })
        end,
    },

    -- コメントアウトの自動化
    {
        "numToStr/Comment.nvim",
        opts = {
            mappings = {
                basic = false,
                extra = false,
            },
        },

        config = function(_, opts)
            local comment = require("Comment")
            comment.setup(opts)

            vim.keymap.set("n", "<leader>c", "gcc", { remap = true, desc = "Comment line", })
            vim.keymap.set("x", "<leader>c", "gc", { remap = true, desc = "Comment selection", })
        end,
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                "c",
                "cpp",
                "java",
                "sql",
                "r",
                "python",
                "rust",
                "go",
                "html",
                "css",
                "javascript",
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "c",
                    "cpp",
                    "java",
                    "sql",
                    "r",
                    "python",
                    "rust",
                    "go",
                    "html",
                    "css",
                    "javascript",
                },
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end,
    },

    -- 各言語のlint
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                -- program lang
                rust = { "clippy" },

                java = { "pmd" }, --None 

                python = { "ruff" },

                c = { "cpplint" },
                cpp = { "cpplint" },

                go = { "golangcilint" },

                html = { "htmlhint" },
                css = { "stylelint" },
                scss = { "stylelint" },
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },

                lua = { "luacheck" },

                r = { "lintr" }, --None 

                -- data lang
                sql = { "sqlfluff" },

                json = { "jsonlint" },

                yaml = { "yamllint" },

                toml = { "tombi" },

            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },

    -- Yaziのファイラを使用する
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>d",
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
        },
        opts = {
            yazi_floating_window_winblend = 0,
            keymaps = { show_help = "<f1>", },
            -- jk移動時のNeovim側バッファ同期（ハイライト）を無効化して再描画フリッカーを止める
            highlight_hovered_buffers_in_same_directory = false,
        },
    },

    -- バッファをタブバーに表示する
    {
        "romgrk/barbar.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        event = "VeryLazy",
        opts = {
            insert_at_end = true,
            icons = {
                button = "×",
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = { enabled = false },
                    [vim.diagnostic.severity.WARN] = { enabled = false },
                    [vim.diagnostic.severity.INFO] = { enabled = false },
                    [vim.diagnostic.severity.HINT] = { enabled = false },
                },
            },
        },
    },

    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            -- <leader>ff : ファイル名検索 (fd)
            { "<leader>ff", function() require("fzf-lua").files() end, desc = "fzfファイル検索" },
            -- <leader>fg : コード内検索 (ripgrep)
            { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "fzf文字列検索" },
            -- <leader>fb : バッファ一覧
            { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "fzfバッファ検索" },
            -- <leader>fh : 最近開いたファイル履歴
            { "<leader>fh", function() require("fzf-lua").oldfiles() end, desc = "fzfファイル履歴検索" },
            -- <leader>fc : Gitコミット履歴
            { "<leader>fc", function() require("fzf-lua").git_commits() end, desc = "fzfコミット履歴検索" },
        },
        config = function()
            require("fzf-lua").setup({
                winopts = {
                    height = 0.85,
                    width = 0.80,
                    row = 0.35,
                    col = 0.50,
                },
            })
        end,
    },
})
