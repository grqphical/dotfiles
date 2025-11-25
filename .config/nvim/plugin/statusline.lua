function ModeStatus()
    local mode_map = {
        n = { label = "NORMAL", hl = "%#MiniStatusLineModeNormal#" },
        i = { label = "INSERT", hl = "%#MiniStatusLineModeInsert#" },
        v = { label = "VISUAL", hl = "%#MiniStatusLineModeVisual#" },
        V = { label = "V-LINE", hl = "%#MiniStatusLineModeVisual#" },
        [""] = { label = "V-BLOCK", hl = "%#MiniStatusLineModeVisual#" },
        c = { label = "COMMAND", hl = "%#MiniStatusLineModeCommand#" },
        R = { label = "REPLACE", hl = "%#MiniStatusLineModeReplace#" },
        s = { label = "SELECT", hl = "%#MiniStatusLineModeSelect#" },
        t = { label = "TERMINAL", hl = "%#MiniStatusLineModeTerminal#" },
    }

    local mode = vim.api.nvim_get_mode().mode
    local m = mode_map[mode] or { label = mode, hl = "%#StatusLine#" }
    return string.format("%s %s ", m.hl, m.label)
end

local statusline = {
    '%{%v:lua.ModeStatus()%}%* ',
    '%t',
    '%r',
    '%m',
    '%=',
    '%y',
    ' %2p%%',
    ' %3l:%-2c '
}

vim.o.showmode = false
vim.o.statusline = table.concat(statusline, '')
