return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- LSP completions
        "L3MON4D3/LuaSnip", -- Snippet engine (required for cmp)
        "saadparwaiz1/cmp_luasnip", -- Snippet completions
        "hrsh7th/cmp-buffer", -- Buffer completion
        "hrsh7th/cmp-path", -- Path completion
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
        })
    end,
}
