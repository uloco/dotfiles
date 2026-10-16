-- hover.nvim provider that merges hover results from all LSP clients into one
-- tab and skips clients that return nothing (e.g. graphql, tailwindcss).

local method = "textDocument/hover"

--- @type Hover.Provider
return {
	name = "LSP",
	enabled = function(bufnr)
		return #vim.lsp.get_clients({ bufnr = bufnr, method = method }) > 0
	end,
	execute = function(params, done)
		local row, col = params.pos[1] - 1, params.pos[2]
		local line = vim.api.nvim_buf_get_lines(params.bufnr, row, row + 1, false)[1] or ""

		vim.lsp.buf_request_all(params.bufnr, method, function(client)
			return {
				textDocument = { uri = vim.uri_from_bufnr(params.bufnr) },
				position = {
					line = row,
					character = vim.str_utfindex(line, client.offset_encoding, math.min(col, #line)),
				},
			}
		end, function(results)
			local lines = {}
			for _, res in pairs(results) do
				local contents = res.result and res.result.contents
				if contents then
					local text = table.concat(vim.lsp.util.convert_input_to_markdown_lines(contents), "\n")
					if vim.trim(text) ~= "" then
						if #lines > 0 then
							table.insert(lines, "---")
						end
						vim.list_extend(lines, vim.split(text, "\n"))
					end
				end
			end
			done(#lines > 0 and { lines = lines, filetype = "markdown" } or nil)
		end)
	end,
}
