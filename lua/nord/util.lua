local util = {}

--- Set the highlights for the named group.
--- @param group string The name of the highlighting group.
--- @param colors table A table containing fg, bg, style, sp and/or link.
--- @param config table A table containing the plugin configurations.
function util.highlight(group, colors, config)
  if colors.link then
    vim.cmd("highlight! link " .. group .. " " .. colors.link)
  else
    local guifg = colors.fg and colors.fg.gui and "guifg=" .. colors.fg.gui
      or "guifg=NONE"
    local guibg = colors.bg and colors.bg.gui and "guibg=" .. colors.bg.gui
      or "guibg=NONE"
    local ctermfg = colors.fg
        and colors.fg.cterm
        and "ctermfg=" .. colors.fg.cterm
      or "ctermfg=NONE"
    local ctermbg = colors.bg
        and colors.bg.cterm
        and "ctermbg=" .. colors.bg.cterm
      or "ctermbg=NONE"
    local guistyle = colors.style and "gui=" .. colors.style or "gui=NONE"
    local ctermstyle = colors.style
        and "cterm=" .. string.gsub(
          colors.style,
          "undercurl",
          { undercurl = config.underline.enabled and "underline" or "" }
        )
      or "cterm=NONE"
    local guisp = colors.sp and colors.sp.gui and "guisp=" .. colors.sp.gui
      or ""

    local hl = "highlight "
      .. group
      .. " "
      .. guifg
      .. " "
      .. guibg
      .. " "
      .. ctermfg
      .. " "
      .. ctermbg
      .. " "
      .. guistyle
      .. " "
      .. ctermstyle
      .. " "
      .. guisp

    vim.cmd(hl)
  end
end

--- Apply the colors for a highlighting group.
--- @param hlgroup table A table of highlighting configurations.
--- @param config table A table containing the plugin configurations.
function util.hlgroup(hlgroup, config)
  for group, colors in pairs(hlgroup) do
    util.highlight(group, colors, config)
  end
end

--- Set the terminal colors.
--- @param colors ColorScheme A color scheme object containing the terminal
--- colors.
function util.terminal(colors)
  -- dark
  vim.g.terminal_color_0 = colors.black.gui
  vim.g.terminal_color_1 = colors.red.gui
  vim.g.terminal_color_2 = colors.green.gui
  vim.g.terminal_color_3 = colors.yellow.gui
  vim.g.terminal_color_4 = colors.blue.gui
  vim.g.terminal_color_5 = colors.magenta.gui
  vim.g.terminal_color_6 = colors.cyan.gui
  vim.g.terminal_color_7 = colors.white.gui
  vim.g.terminal_color_8 = colors.darkgrey.gui
  vim.g.terminal_color_9 = colors.red.gui
  vim.g.terminal_color_10 = colors.green.gui
  vim.g.terminal_color_11 = colors.yellow.gui
  vim.g.terminal_color_12 = colors.blue.gui
  vim.g.terminal_color_13 = colors.magenta.gui
  vim.g.terminal_color_14 = colors.cyan.gui
  vim.g.terminal_color_15 = colors.white.gui
end

--- Load the theme object and set highlights.
--- @param theme Theme The theme object to be loaded
function util.load(theme)
  -- The highlights only need to be cleared when the theme is not the default
  -- color scheme
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "nord"

  util.hlgroup(theme.base, theme.config)
  util.hlgroup(theme.additional, theme.config)
  util.hlgroup(theme.languages, theme.config)
  util.hlgroup(theme.plugins, theme.config)
  util.terminal(theme.colors)
end

return util
