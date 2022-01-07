vim.g.python3_host_prog = "/home/zach/.virtualenvs/py3nvim/bin/python"
vim.g.python_host_prog = "/home/zach/.virtualenvs/py2nvim/bin/python"
vim.g.python_host_skip_check=1

vim.g.clipboard = {
	name= 'unnamedplus',
	copy = {
		["+"] = 'xclip -i -selection clipboard',
		["*"] = 'xclip -i -selection primary',
	},
	paste= {
		["+"] = 'xclip -o -selection clipboard',
		["*"] = 'xclip -o -selection primary',
	},
	cache_enabled = 0
}

vim.cmd[[ set noshowmode ]]
vim.cmd[[ set nosc ]]
