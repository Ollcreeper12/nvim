local M = {}

local render_win = nil
local render_buf = nil

function M.setup()
	vim.api.nvim_create_user_command("MR", function(opts)
		local args = opts.fargs
		local file = args[1] or vim.fn.expand("%:p")
		local scene = args[2]

		if vim.fn.executable("uv") ~= 1 then
			vim.notify("Manim Render: uv not in path", vim.log.levels.ERROR)
			return
		end

		if args[1] == "." then
			file = vim.fn.expand("%:p")
		end

		-- Check the file extension
		if vim.fn.fnamemodify(file, ":e") ~= "py" then
			vim.notify("Usage: :MR <file.py> <scene>", vim.log.levels.ERROR)
			return
		end

		-- Check that a scene was supplied
		if not scene then
			vim.notify("Usage: :MR <file.py> <scene>", vim.log.levels.ERROR)
			return
		end

		if render_win and vim.api.nvim_win_is_valid(render_win) then
			vim.api.nvim_win_close(render_win, true)
		end
		if render_buf and vim.api.nvim_buf_is_valid(render_buf) then
			vim.api.nvim_buf_delete(render_buf, { force = true })
		end

		-- Save the current buffer
		vim.cmd("update")

		vim.cmd("botright 12new")

		local this_win = vim.api.nvim_get_current_win()
		local this_buf = vim.api.nvim_get_current_buf()

		render_win = this_win
		render_buf = this_buf

		-- Build the Manim command
		local command = {
			"uv",
			"run",
			"manim",
			file,
			scene,
			"-pqh",
		}

		vim.fn.termopen(command, {
			on_exit = function(_, code)
				vim.schedule(function()
					if code == 0 then
						if vim.api.nvim_win_is_valid(this_win) then
							vim.api.nvim_win_close(this_win, true)
						end

						if vim.api.nvim_buf_is_valid(this_buf) then
							vim.api.nvim_buf_delete(this_buf, { force = true })
						end

						if render_win == this_win then
							render_win = nil
							render_buf = nil
						end
					end
				end)
			end,
		})

		vim.cmd("startinsert")
	end, {
		nargs = "*",
		desc = "Render a Manim animation",
		complete = "file",
	})
end

return M
