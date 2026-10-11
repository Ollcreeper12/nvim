-- Configure the Lualine statusline plugin.
return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",

    -- Load Catppuccin so Lualine can use its theme.
    dependencies = {
        "catppuccin/nvim",
    },

    opts = {
        options = {
            -- Use the Catppuccin theme.
            theme = "catppuccin-nvim",

            -- Separate components with vertical bars.
            component_separators = {
                left = "|",
                right = "|",
            },

            -- Use slanted separators between sections.
            section_separators = {
                left = "",
                right = "",
            },
        },

        sections = {
            -- Leftmost section: current editing mode.
            lualine_a = {
                { "mode", icon = "" },
            },

            -- Git branch, file changes, and diagnostics.
            lualine_b = {
                { "branch", icon = "" },
                {
                    "diff",
                    symbols = {
                        added = " ",
                        modified = " ",
                        removed = " ",
                    },
                },
                {
                    "diagnostics",
                    symbols = {
                        error = " ",
                        warn = " ",
                        info = " ",
                        hint = "󰌵 ",
                    },
                },
            },

            -- Filename and relative path.
            lualine_c = {
                {
                    "filename",
                    path = 1,
                    icon = "󰈔",
                },
            },

            -- File metadata and file-type icon.
            lualine_x = {
                { "encoding", icon = "󰉿" },
                { "fileformat", icons_enabled = true },
                { "filetype", icon_only = true },
            },

            -- Right side: progress and cursor position.
            lualine_y = {
                { "progress", icon = "󰹑" },
            },
            lualine_z = {
                { "location", icon = "󰍎" },
            },
        },
    },
}
