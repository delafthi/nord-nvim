--- @class ColorScheme
local colors = {
  none = "NONE",

  -- GUI colors
  nord0 = { gui = "#2E3440", cterm = 0 },
  nord1 = { gui = "#3B4252", cterm = 0 },
  nord2 = { gui = "#434C5E", cterm = 8 },
  nord3 = { gui = "#4C566A", cterm = 8 },
  nord3_bright = { gui = "#616E88", cterm = 8 },
  nord4 = { gui = "#D8DEE9", cterm = 7 },
  nord5 = { gui = "#E5E9F0", cterm = 7 },
  nord6 = { gui = "#ECEFF4", cterm = 15 },
  nord7 = { gui = "#8FBCBB", cterm = 14 },
  nord8 = { gui = "#88C0D0", cterm = 6 },
  nord9 = { gui = "#81A1C1", cterm = 4 },
  nord10 = { gui = "#5E81AC", cterm = 12 },
  nord11 = { gui = "#BF616A", cterm = 1 },
  nord12 = { gui = "#D08770", cterm = 11 },
  nord13 = { gui = "#EBCB8B", cterm = 3 },
  nord14 = { gui = "#A3BE8C", cterm = 2 },
  nord15 = { gui = "#B48EAD", cterm = 5 },
}

colors.black = colors.nord1
colors.darkgrey = colors.nord3
colors.grey = colors.nord3_bright
colors.white = colors.nord4
colors.red = colors.nord11
colors.green = colors.nord14
colors.yellow = colors.nord13
colors.blue = colors.nord9
colors.magenta = colors.nord15
colors.cyan = colors.nord8

colors.error = colors.nord11
colors.warning = colors.nord13
colors.info = colors.nord8
colors.hint = colors.nord10
colors.success = colors.nord14

colors.add = colors.nord14
colors.remove = colors.nord11
colors.change = colors.nord13

return colors
