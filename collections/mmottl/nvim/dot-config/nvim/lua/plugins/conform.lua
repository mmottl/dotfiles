return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      java = { "google-java-format" },
      bzl = { "buildifier" },
      markdown = { "dprint" },
    },
    -- log_level = vim.log.levels.DEBUG,
  },
}
