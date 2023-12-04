require("dinozor.lazy") -- Should load Lazy packager and plugins
require("dinozor.set")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', {})

vim.keymap.set('n', '<leader>p', '"+p', {})
vim.keymap.set('n', '<leader>P', '"+P', {})
vim.keymap.set('v', '<leader>y', '"+y', {})
vim.keymap.set('n', '<leader>y', '"+yy', {})

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
