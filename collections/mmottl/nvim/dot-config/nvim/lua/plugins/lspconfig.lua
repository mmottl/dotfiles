return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      jdtls = {
        on_attach = function(client)
          print("jdtls_override.lua loaded!")
          -- Disable jdtls's built-in formatting
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- If LazyVim’s default config sets on_attach, you might want
          -- to chain-call it here. e.g.:
          -- if existing_on_attach then
          --   existing_on_attach(client, bufnr)
          -- end
        end,
        -- If you have other jdtls options, put them here (e.g., root_dir, cmd, etc.)
      },
    },
  },
}
