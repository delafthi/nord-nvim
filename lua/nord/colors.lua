--- @class ColorScheme
local colors = {
  none = "NONE",

  -- GUI colors
  nord0 = "#2E3440",
  nord1 = "#3B4252",
  nord2 = "#434C5E",
  nord3 = "#4C566A",
  nord3_bright = "#616E88",
  nord4 = "#D8DEE9",
  nord5 = "#E5E9F0",
  nord6 = "#ECEFF4",
  nord7 = "#8FBCBB",
  nord8 = "#88C0D0",
  nord9 = "#81A1C1",
  nord10 = "#5E81AC",
  nord11 = "#BF616A",
  nord12 = "#D08770",
  nord13 = "#EBCB8B",
  nord14 = "#A3BE8C",
  nord15 = "#B48EAD",
}

colors.black = colors.nord0
colors.terminal_black = colors.nord3
colors.fg_dark = colors.nord3_bright
colors.fg = colors.nord4
colors.red = colors.nord11
colors.green = colors.nord14
colors.yellow = colors.nord13
colors.blue = colors.nord9
colors.magenta = colors.nord15
colors.cyan = colors.nord7

colors.error = colors.nord11
colors.warning = colors.nord13
colors.info = colors.nord8
colors.hint = colors.nord10
colors.success = colors.nord14

colors.add = colors.nord14
colors.remove = colors.nord11
colors.change = colors.nord13

return colors
