return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = { 
    },
    config = function()
        local wk = require("which-key")
        wk.add({
            {"<leader>c", desc = "[C]ode <A>ction",   mode = {"n", "v"}, icon = ""},
            {"<leader>d", desc = "[D]iagnostics",     mode = {"n", "v"}, icon = ""},
            {"<leader>g", group = "[G]it",             mode = {"n", "v"}, icon = ""},
            {"<leader>p", name = "[P]roject",         mode = {"n", "v"}, icon = ""},
            {"<leader>pg", name = "[P]roject [G]rep",  mode = {"n", "v"}, icon = ""},
            {"<leader>r", name = "[R]e<N>ame",        mode = {"n", "v"}, icon = "󰑕"},
            {"<leader>s", name = "[S]earch (Misc)",   mode = {"n", "v"}, icon = "" },
            {"<leader>t", name = "[T]oggle",          mode = {"n", "v"}, icon = "󰔡"},
            {"<leader>w", name = "[W]orkspace",       mode = {"n"},      icon = ""},
        })
    end
}
