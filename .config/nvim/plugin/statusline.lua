_G.ModeStatus = function()
    local mode_map = {
        ['n']   = { label = "NORMAL", hl = "%#MiniStatusLineModeNormal#" },
        ['i']   = { label = "INSERT", hl = "%#MiniStatusLineModeInsert#" },
        ['v']   = { label = "VISUAL", hl = "%#MiniStatusLineModeVisual#" },
        ['V']   = { label = "V-LINE", hl = "%#MiniStatusLineModeVisual#" },
        ['\22'] = { label = "V-BLOCK", hl = "%#MiniStatusLineModeVisual#" },
        ['c']   = { label = "COMMAND", hl = "%#MiniStatusLineModeCommand#" },
        ['R']   = { label = "REPLACE", hl = "%#MiniStatusLineModeReplace#" },
        ['s']   = { label = "SELECT", hl = "%#MiniStatusLineModeSelect#" },
        ['t']   = { label = "TERMINAL", hl = "%#MiniStatusLineModeTerminal#" },
    }

    local mode = vim.api.nvim_get_mode().mode
    local m = mode_map[mode] or { label = mode, hl = "%#StatusLine#" }
    return string.format("%s %s %%* ", m.hl, m.label)
end

_G.FileTypeIcon = function()
    local ft = vim.bo.filetype
    if ft == '' then return '' end -- Return empty if no filetype

    local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
    if has_devicons then
        local filename = vim.fn.expand('%:t')
        local icon, color = devicons.get_icon_color(filename, ft)

        if icon then
            vim.api.nvim_set_hl(0, 'StatuslineIcon', { fg = color, bg = 'none' })
            return string.format('%%#StatuslineIcon#%s%%* ', icon)
        end
    end
    return ''
end

-- 2. Build the statusline table
local statusline = {
    '%{%v:lua.ModeStatus()%}',   -- Mode with colors
    '%t',                        -- Tail of filename
    ' %r',                       -- Read-only flag
    '%m',                        -- Modified flag
    '%=',                        -- Right align separator
    '%{%v:lua.FileTypeIcon()%}', -- Icon with dynamic color
    '%{&filetype} ',             -- Filetype name (no brackets)
    ' %2p%%',                    -- Percentage through file
    ' %3l:%-2c '                 -- Line:Column
}

-- 3. Apply settings
vim.o.showmode = false
vim.o.statusline = table.concat(statusline, '')
