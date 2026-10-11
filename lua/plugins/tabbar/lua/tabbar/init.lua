local M = {}

local state = {
    bar_buf = nil,
    bar_win = nil,
    main_win = nil,
    scroll = 1,
    tabs = {},
    namespace = vim.api.nvim_create_namespace("ui_bar"),
}

-- Catppuccin Mocha colours
local function setup_highlights()
    local groups = {
        UiBarActive = {
            fg = "#cdd6f4",
            bg = "#45475a",
            bold = true,
        },
        UiBarInactive = {
            fg = "#a6adc8",
            bg = "#181825",
        },
        UiBarModified = {
            fg = "#f9e2af",
            bg = "#181825",
        },
        UiBarActiveModified = {
            fg = "#f9e2af",
            bg = "#45475a",
            bold = true,
        },
    }

    for name, opts in pairs(groups) do
        vim.api.nvim_set_hl(0, name, opts)
    end
end

-- Get all listed buffers
local function get_buffers()
    local result = {}

    for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        if vim.api.nvim_buf_is_valid(buf.bufnr) then
            table.insert(result, buf.bufnr)
        end
    end

    return result
end

-- Get a buffer's display name, icon and modified state
local function get_label(buf)
    local name = vim.api.nvim_buf_get_name(buf)
    local filename = name == ""
        and "[No Name]"
        or vim.fn.fnamemodify(name, ":t")

    local icon = ""
    local ok, devicons = pcall(require, "nvim-web-devicons")

    if ok and name ~= "" then
        icon = devicons.get_icon(filename, nil, { default = true }) or ""
    end

    if icon ~= "" then
        icon = icon .. " "
    end

    local modified = vim.bo[buf].modified
    local marker = modified and " +" or ""

    return icon .. filename .. marker, modified
end

-- Create the bar window and its scratch buffer
local function create_bar()
    if state.bar_win and vim.api.nvim_win_is_valid(state.bar_win) then
        return
    end

    state.main_win = vim.api.nvim_get_current_win()

    local buf = vim.api.nvim_create_buf(false, true)
    state.bar_buf = buf

    vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
    vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

    -- Open a one-line split at the top
    vim.cmd("topleft 1split")
    state.bar_win = vim.api.nvim_get_current_win()

    vim.api.nvim_win_set_buf(state.bar_win, buf)
    vim.api.nvim_set_option_value("winfixheight", true, {
        win = state.bar_win,
    })
    vim.api.nvim_set_option_value("number", false, {
        win = state.bar_win,
    })
    vim.api.nvim_set_option_value("relativenumber", false, {
        win = state.bar_win,
    })
    vim.api.nvim_set_option_value("signcolumn", "no", {
        win = state.bar_win,
    })
    vim.api.nvim_set_option_value("wrap", false, {
        win = state.bar_win,
    })
    vim.api.nvim_set_option_value("winhighlight",
        "Normal:UiBarInactive,EndOfBuffer:UiBarInactive",
        { win = state.bar_win }
    )

    -- Clicking a tab switches to that buffer
    vim.keymap.set("n", "<LeftMouse>", function()
        local mouse = vim.fn.getmousepos()
        local col = mouse.wincol - 1

        for _, tab in ipairs(state.tabs) do
            if col >= tab.first and col < tab.last then
                local target = tab.buf

                if state.main_win
                    and vim.api.nvim_win_is_valid(state.main_win)
                    and vim.api.nvim_buf_is_valid(target)
                then
                    vim.api.nvim_win_set_buf(state.main_win, target)
                    vim.api.nvim_set_current_win(state.main_win)
                end

                return
            end
        end
    end, { buffer = buf, desc = "Switch tab" })

    vim.keymap.set("n", "<Tab>", M.scroll_right, {
        buffer = buf,
        desc = "Scroll tabbar right",
    })
    vim.keymap.set("n", "<S-Tab>", M.scroll_left, {
        buffer = buf,
        desc = "Scroll tabbar left",
    })

    vim.api.nvim_set_current_win(state.main_win)
end

-- Show the bar only when there are multiple buffers
local function update_visibility()
    local buffers = get_buffers()
    local should_show = #buffers > 1

    if should_show then
        if not state.bar_win or not vim.api.nvim_win_is_valid(state.bar_win) then
            create_bar()
        end

        if state.bar_win and vim.api.nvim_win_is_valid(state.bar_win) then
            vim.api.nvim_win_set_height(state.bar_win, 1)
            vim.api.nvim_set_option_value("winfixheight", true, {
                win = state.bar_win,
            })
        end
    elseif state.bar_win and vim.api.nvim_win_is_valid(state.bar_win) then
        vim.api.nvim_win_close(state.bar_win, true)
        state.bar_win = nil
        state.bar_buf = nil
    end
end

-- Render the visible buffer tabs
function M.render()
    update_visibility()
    if not state.bar_buf
        or not vim.api.nvim_buf_is_valid(state.bar_buf)
        or not state.bar_win
        or not vim.api.nvim_win_is_valid(state.bar_win)
    then
        return
    end

    setup_highlights()

    local buffers = get_buffers()
    local current = state.main_win
        and vim.api.nvim_win_is_valid(state.main_win)
        and vim.api.nvim_win_get_buf(state.main_win)
        or vim.api.nvim_get_current_buf()

    local width = vim.api.nvim_win_get_width(state.bar_win)
    local parts = {}
    local highlights = {}
    state.tabs = {}

    local line = ""
    local col = 0
    local index = state.scroll

    if index > 1 then
        line = "‹ "
        col = #line
    end

    while index <= #buffers do
        local buf = buffers[index]
        local label, modified = get_label(buf)
        local active = buf == current
        local text = " " .. label .. " "
        local reserve = index < #buffers and 2 or 0

        if col + #text + reserve > width then
            if col == 0 then
                text = text:sub(1, math.max(1, width - reserve))
            else
                break
            end
        end

        local first = col
        line = line .. text
        col = col + #text

        table.insert(highlights, {
            first = first,
            last = col,
            group = active
                and (modified and "UiBarActiveModified" or "UiBarActive")
                or (modified and "UiBarModified" or "UiBarInactive"),
        })

        table.insert(state.tabs, {
            buf = buf,
            first = first,
            last = col,
        })

        index = index + 1
    end

    if index <= #buffers then
        line = line .. " ›"
    end

    line = line:sub(1, width)
    line = line .. string.rep(" ", math.max(0, width - #line))

    vim.api.nvim_set_option_value("modifiable", true, {
        buf = state.bar_buf,
    })
    vim.api.nvim_buf_set_lines(state.bar_buf, 0, -1, false, { line })
    vim.api.nvim_buf_clear_namespace(
        state.bar_buf, state.namespace, 0, -1
    )

    for _, hl in ipairs(highlights) do
        vim.api.nvim_buf_add_highlight(
            state.bar_buf,
            state.namespace,
            hl.group,
            0,
            hl.first,
            math.min(hl.last, width)
        )
    end

    vim.api.nvim_set_option_value("modifiable", false, {
        buf = state.bar_buf,
    })
end

-- Scroll through buffers
function M.scroll_left()
    state.scroll = math.max(1, state.scroll - 1)
    M.render()
end

function M.scroll_right()
    local buffers = get_buffers()
    state.scroll = math.min(#buffers, state.scroll + 1)
    M.render()
end

-- Initialise the plugin
function M.setup()
    setup_highlights()

    local group = vim.api.nvim_create_augroup("UiBar", {
        clear = true,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
        group = group,
        once = true,
        callback = function()
            create_bar()
            M.render()
        end,
    })

    vim.api.nvim_create_autocmd({
        "BufAdd",
        "BufDelete",
        "BufEnter",
        "BufModifiedSet",
        "BufWritePost",
        "VimResized",
        "FileType",
    }, {
        group = group,
        callback = function()
            update_visibility()
            vim.schedule(M.render)
        end,
    })

    vim.api.nvim_create_autocmd("WinEnter", {
        group = group,
        callback = function()
            local win = vim.api.nvim_get_current_win()

            if win ~= state.bar_win then
                state.main_win = win
                vim.schedule(M.render)
            end
        end,
    })
end

return M
