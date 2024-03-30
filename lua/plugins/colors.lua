--function ColorMyPencils(color)
--    color = color or "catppuccin-mocha"
--    vim.cmd.colorscheme(color)
--
--    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                disable_background = true,
            })

            --            vim.cmd("colorscheme rose-pine")

            --            ColorMyPencils()
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = true, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark", -- style for floating windows
                },
            })
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        config = function()
            -- Default options:
            require("kanagawa").setup({
                compile = false, -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false, -- do not set background color
                dimInactive = false, -- dim inactive window `:h hl-NormalNC`
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
                colors = { -- add/modify theme and palette colors
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function(colors) -- add/modify highlights
                    return {}
                end,
                theme = "wave", -- Load "wave" theme when 'background' option is not set
                background = { -- map the value of 'background' option to a theme
                    dark = "wave", -- try "dragon" !
                    light = "lotus",
                },
            })

            -- setup must be called before loading
            --            vim.cmd("colorscheme kanagawa")
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        name = "nightfox",
        config = function()
            -- Default options
            require("nightfox").setup({
                options = {
                    -- Compiled file's destination location
                    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
                    compile_file_suffix = "_compiled", -- Compiled file suffix
                    transparent = false, -- Disable setting background
                    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                    dim_inactive = false, -- Non focused panes set to alternative background
                    module_default = true, -- Default enable value for modules
                    colorblind = {
                        enable = false, -- Enable colorblind support
                        simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
                        severity = {
                            protan = 0, -- Severity [0,1] for protan (red)
                            deutan = 0, -- Severity [0,1] for deutan (green)
                            tritan = 0, -- Severity [0,1] for tritan (blue)
                        },
                    },
                    styles = { -- Style to be applied to different syntax groups
                        comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
                        conditionals = "NONE",
                        constants = "NONE",
                        functions = "NONE",
                        keywords = "NONE",
                        numbers = "NONE",
                        operators = "NONE",
                        strings = "NONE",
                        types = "NONE",
                        variables = "NONE",
                    },
                    inverse = { -- Inverse highlight for different types
                        match_paren = false,
                        visual = false,
                        search = false,
                    },
                    modules = { -- List of various plugins and additional options
                        -- ...
                    },
                },
                palettes = {},
                specs = {},
                groups = {},
            })

            -- setup must be called before loading
            --            vim.cmd("colorscheme nightfox")
        end,
    },
}
