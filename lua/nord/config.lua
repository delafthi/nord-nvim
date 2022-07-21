--- The configuration object containing the same settings as the original
--- nord-vim theme.
local config = {}

local function opt(key, default)
  key = "nord_" .. key
  if vim.g[key] == nil then
    return default
  end
  if vim.g[key] == 0 then
    return false
  end
  return vim.g[key]
end

config = {
  bold = {
    enabled = opt("bold.enabled", true),
  },
  italic = {
    enabled = opt("italic.enabled", true),
    comment = opt("italic.comment", false),
    boolean = opt("italics.booleans", true),
    statement = opt("italic.statement", true),
    conditional = opt("italic.conditional", true),
    ["repeat"] = opt("italic.repeat", true),
    label = opt("italic.label", true),
    operator = opt("italic.operator", false),
    keyword = opt("italic.keyword", true),
    exception = opt("italic.exception", true),
  },
  underline = {
    enabled = opt("underline.enabled", true),
  },
  undercurl = {
    enabled = opt("undercurl.enabled", true),
  },
  cursor_line_number_background = opt("cursor_line_number_background", true),
  uniform_status_lines = opt("uniform_status_lines", true),
  bold_vertical_split_line = opt("bold_vertical_split_line", true),
  uniform_diff_background = opt("uniform_diff_background", true),
}

return config
