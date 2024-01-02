return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
        {
            "<leader>fe",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = require("dinozor.util").root() })
            end,
            desc = "Explorer NeoTree (root dir)",
        },
        {
            "<leader>fE",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
            end,
            desc = "Explorer NeoTree (cwd)",
        },
--         { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
        { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
        {
            "<leader>ge",
            function()
                require("neo-tree.command").execute({ source = "git_status", toggle = true })
            end,
            desc = "Git explorer",
        },
        {
            "<leader>be",
            function()
                require("neo-tree.command").execute({ source = "buffers", toggle = true })
            end,
            desc = "Buffer explorer",
        },
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    opts = {
        sources = { "filesystem", "buffers", "git_status", "document_symbols" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
        filesystem = {
            bind_to_cwd = false,
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
        },
        window = {
            mappings = {
                ["<space>"] = "none",
            },
        },
        close_if_last_window = false,
        default_component_configs = {
            indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
        },
    },
    config = function(_, opts)
        local function on_move(data)
            Util.lsp.on_rename(data.source, data.destination)
        end

        local events = require("neo-tree.events")
        opts.event_handlers = opts.event_handlers or {}
        vim.list_extend(opts.event_handlers, {
            { event = events.FILE_MOVED, handler = on_move },
            { event = events.FILE_RENAMED, handler = on_move },
        })
        require("neo-tree").setup(opts)
        vim.api.nvim_create_autocmd("TermClose", {
            pattern = "*lazygit",
            callback = function()
                if package.loaded["neo-tree.sources.git_status"] then
                    require("neo-tree.sources.git_status").refresh()
                end
            end,
        })
    end,
    --config = function(_, opts) {
    --    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    --    popup_border_style = "rounded",
    --    enable_git_status = true,
    --    enable_diagnostics = true,
    --    enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
    --    open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
    --    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    --    sort_function = nil , -- use a custom function for sorting files and directories in the tree 
    --}
}
