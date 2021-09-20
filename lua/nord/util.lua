local util = {}

--- Set the highlights for the named group.
--- @param group string The name of the highlighting group.
--- @param colors table A table containing fg, bg, style, sp and/or link.
function util.highlight(group, colors)
  if colors.link then
    vim.cmd("highlight! link " .. group .. " " .. colors.link)
  else
    local style = colors.style and "gui=" .. colors.style or "gui=NONE"
    local fg = colors.fg and "guifg=" .. colors.fg or "guifg=NONE"
    local bg = colors.bg and "guibg=" .. colors.bg or "guibg=NONE"
    local sp = colors.sp and "guisp=" .. colors.sp or ""

    local hl = "highlight "
      .. group
      .. " "
      .. style
      .. " "
      .. fg
      .. " "
      .. bg
      .. " "
      .. sp

    vim.cmd(hl)
  end
end

--- Apply the colors for a highlighting group.
--- @param hlgroup table A table of highlighting configurations.
function util.hlgroup(hlgroup)
  for group, colors in pairs(hlgroup) do
    util.highlight(group, colors)
  end
end

--- Set the terminal colors.
--- @param colors ColorScheme A color scheme object containing the terminal
--- colors.
function util.terminal(colors)
  -- dark
  vim.g.terminal_color_0 = colors.black
  vim.g.terminal_color_8 = colors.terminal_black

  -- light
  vim.g.terminal_color_7 = colors.fg_dark
  vim.g.terminal_color_15 = colors.fg

  -- colors
  vim.g.terminal_color_1 = colors.red
  vim.g.terminal_color_9 = colors.red

  vim.g.terminal_color_2 = colors.green
  vim.g.terminal_color_10 = colors.green

  vim.g.terminal_color_3 = colors.yellow
  vim.g.terminal_color_11 = colors.yellow

  vim.g.terminal_color_4 = colors.blue
  vim.g.terminal_color_12 = colors.blue

  vim.g.terminal_color_5 = colors.magenta
  vim.g.terminal_color_13 = colors.magenta

  vim.g.terminal_color_6 = colors.cyan
  vim.g.terminal_color_14 = colors.cyan
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

  util.hlgroup(theme.base)
  util.hlgroup(theme.additional)
  util.hlgroup(theme.languages)
  util.hlgroup(theme.plugins)
  util.terminal(theme.colors)
end

return util
