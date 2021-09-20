local util = require("nord.util")
local theme = require("nord.theme")

local M = {}

--- Enable and load the color scheme
function M.colorscheme()
  util.load(theme.setup())
end

--- Setup function if the colorscheme is called from lua
--- @param config table A configuration table
function M.setup(config)
  vim.g.colors_name = "nord"
  util.load(theme.setup(config))
end

return M
