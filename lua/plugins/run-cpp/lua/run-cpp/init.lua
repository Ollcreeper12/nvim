local M = {}

local render_win = nil
local render_buf = nil
local render_job = nil

local vcvars = [[C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvarsall.bat]]

local function quote(path)
	return '"' .. path:gsub('"', '""') .. '"'
end

local function close_previous()
	if render_job then
		pcall(vim.fn.jobstop, render_job)
		render_job = nil
	end

	if render_win and vim.api.nvim_win_is_valid(render_win) then
		vim.api.nvim_win_close(render_win, true)
	end

	if render_buf and vim.api.nvim_buf_is_valid(render_buf) then
		vim.api.nvim_buf_delete(render_buf, { force = true })
	end

	render_win = nil
	render_buf = nil
end

function M.setup()
	vim.api.nvim_create_user_command("RunCpp", function(opts)
		local file = opts.args

		if file == "" or file == "." then
			file = vim.fn.expand("%:p")
		else
			file = vim.fn.fnamemodify(file, ":p")
		end

		local ext = vim.fn.fnamemodify(file, ":e"):lower()

		if vim.fn.filereadable(file) ~= 1 or not vim.tbl_contains({ "cpp", "cc", "cxx" }, ext) then
			vim.notify("Usage: :RunCpp [file.cpp]", vim.log.levels.ERROR)
			return
		end

		if vim.fn.filereadable(vcvars) ~= 1 then
			vim.notify("MSVC environment script not found", vim.log.levels.ERROR)
			return
		end

		vim.cmd("update")
		close_previous()

		local exe = vim.fn.fnamemodify(file, ":r") .. ".exe"
		local cwd = vim.fn.fnamemodify(file, ":h")

		vim.cmd("botright 12new")

		render_win = vim.api.nvim_get_current_win()
		render_buf = vim.api.nvim_get_current_buf()

		-- Start an interactive CMD inside Neovim's terminal buffer.
		render_job = vim.fn.jobstart({ "cmd.exe", "/d" }, {
			term = true,
			cwd = cwd,
			on_exit = function(_, code)
				vim.schedule(function()
					vim.notify(
						"RunCpp shell exited with code " .. code,
						code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
					)
				end)
			end,
		})

		if render_job <= 0 then
			vim.notify("Failed to start CMD terminal", vim.log.levels.ERROR)
			return
		end

		-- Call vcvarsall in the persistent shell.
		vim.fn.chansend(render_job, 'call "' .. vcvars .. '" x64\r')

		-- Queue compilation and execution after environment setup.
		local command = table.concat({
			"echo.",
			"echo === Compiling ===",
			"cl /nologo /EHsc /std:c++20 /Fe:" .. quote(exe) .. " " .. quote(file),
			"if errorlevel 1 (echo Compilation failed) else (echo. & echo === Running === & " .. quote(exe) .. ")",
			"echo.",
		}, " & ")

		vim.fn.chansend(render_job, command .. "\r")

		vim.cmd("startinsert")
	end, {
		nargs = "?",
		complete = "file",
		desc = "Compile and run a C++ file with MSVC",
	})
end

return M
