local fn = vim.fn
local api = vim.api
local fmt = string.format

vim.o.laststatus = 3

local function augroup(name, autocmds, noclear)
  vim.cmd("augroup " .. name)
  if not noclear then
    vim.cmd "autocmd!"
  end
  for _, c in ipairs(autocmds) do
    local command = c.command
    vim.cmd(
      fmt(
        "autocmd %s %s %s %s",
        table.concat(c.events, ","),
        table.concat(c.targets or {}, ","),
        table.concat(c.modifiers or {}, " "),
        command
      )
    )
  end
  vim.cmd "augroup END"
end

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
  local current_mode = api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
  local current_mode = api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
    mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
    mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
    mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
    mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
    mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end

local function filepath()
  local fpath = fn.fnamemodify(fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
    return " "
  end

  return string.format(" %%<%s/", fpath)
end

local function filename()
  local fname = fn.expand "%:t"
  if fname == "" then
    return ""
  end
  return fname .. " "
end

-- local function filetype()
--   return string.format(" %s ", vim.bo.filetype):upper()
-- end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %#Normal# %l:%c "
end

local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#LspDiagnosticsSignError# " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#LspDiagnosticsSignInformation# " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#Normal#"
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    "%#Statusline#",
    update_mode_colors(),
    mode(),
    "%#Normal#",
    filepath(),
    filename(),
    "%#Normal#",
    lsp(),
    "%=%#StatusLineExtra#",
    -- filetype(),
    lineinfo(),
  }
end

function Statusline.inactive()
  return ""
end

function Statusline.short()
  return ""
end

augroup("Statusline", {
  {
    events = { "WinEnter,BufEnter" },
    targets = { "*" },
    command = "setlocal statusline=%!v:lua.Statusline.active()",
  },
  {
    events = { "WinLeave,BufLeave" },
    targets = { "*" },
    command = "setlocal statusline=%!v:lua.Statusline.inactive()",
  },
  {
    events = { "WinEnter,BufEnter" },
    targets = { "NvimTree" },
    command = "setlocal statusline=%!v:lua.Statusline.short()",
  },
})