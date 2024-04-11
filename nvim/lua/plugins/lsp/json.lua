require('lspconfig').jsonls.setup {
	settings = {
		json = {
			schemas = {
				{
					fileMatch = { "*.json" },
					url = "http://json.schemastore.org/tsconfig"
				}
			}
		},
		format = {
			enable = true
		}
	}
}

