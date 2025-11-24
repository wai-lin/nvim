local M = {}
local uv = vim.uv or vim.loop

local CONFIG_NAME = ".nvimrc.json"

local function read_file(path)
	local fd = uv.fs_open(path, "r", 438)
	if not fd then
		return nil
	end
	local stat = uv.fs_fstat(fd)
	if not stat then
		uv.fs_close(fd)
		return nil
	end
	local data = uv.fs_read(fd, stat.size, 0)
	uv.fs_close(fd)
	return data
end

local function find_root(start)
	-- Use LSP root if available, else walk up looking for config file
	local sep = package.config:sub(1, 1)
	local dir = start
	if not dir or dir == "" then
		return nil
	end
	-- normalize to directory
	local is_dir = (uv.fs_stat(dir) or {}).type == "directory"
	if not is_dir then
		dir = dir:match("(.*" .. vim.pesc(sep) .. ")") or "."
	end
	if dir:sub(-1) == sep then
		dir = dir:sub(1, -2)
	end

	local function parent_of(d)
		return d:match("(.*)" .. vim.pesc(sep) .. "[^" .. vim.pesc(sep) .. "]+$")
	end

	while dir and dir ~= "" do
		local candidate = dir .. sep .. CONFIG_NAME
		if uv.fs_stat(candidate) then
			return dir, candidate
		end
		local parent = parent_of(dir)
		if not parent or parent == dir then
			break
		else
			dir = parent
		end
	end
	return nil, nil
end

local cache = {}

function M.load_for_buf(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(bufnr)
	if file == "" then
		return {}
	end

	-- cache by root path
	local root, cfg_path = find_root(file)
	if not root or not cfg_path then
		return {}
	end
	if cache[cfg_path] ~= nil then
		return cache[cfg_path]
	end

	local data = read_file(cfg_path)
	if not data or data == "" then
		cache[cfg_path] = {}
		return cache[cfg_path]
	end

	local ok, parsed = pcall(vim.json.decode, data)
	if not ok then
		vim.notify("Invalid JSON in " .. CONFIG_NAME, vim.log.levels.WARN)
		cache[cfg_path] = {}
		return cache[cfg_path]
	end
	cache[cfg_path] = parsed or {}
	return cache[cfg_path]
end

function M.get(path_tbl, default, bufnr)
	local cfg = M.load_for_buf(bufnr)
	local cur = cfg
	for _, k in ipairs(path_tbl) do
		if type(cur) ~= "table" then
			return default
		end
		cur = cur[k]
	end
	if cur == nil then
		return default
	end
	return cur
end

return M
