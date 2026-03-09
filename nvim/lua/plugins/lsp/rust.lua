vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      -- checkOnSave = {
      --   command = "clippy",
      -- },
      procMacro = {
        enable = false,
      },
      files = {
        excludeDirs = { "target", ".git" },
      },
      diagnostics = {
        enable = true,
      },
    },
  },
})
vim.lsp.enable("rust_analyzer")
