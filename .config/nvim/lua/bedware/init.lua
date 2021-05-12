require("bedware.telescope")
require("bedware.git-worktree")
require("bedware.harpoon")
require("bedware.lsp")
require("bedware.statusline")

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

