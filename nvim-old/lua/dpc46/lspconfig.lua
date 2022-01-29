-- define a function to auto add language servers
-- require('lspconfig').pyright.setup {}


local nvim_lsp = require('lspconfig')
local servers = { 'pyright' }

local on_attach = function()


for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {}
end

