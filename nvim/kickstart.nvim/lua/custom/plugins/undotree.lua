local nmap = function(keys, func, desc)
	if desc then
		desc = '' .. desc
	end

	vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

return {
	'mbbill/undotree',
	config = function()
		nmap('<leader>u', vim.cmd.UndotreeToggle, 'Toggle the [U]ndo-tree panel')
	end
}
