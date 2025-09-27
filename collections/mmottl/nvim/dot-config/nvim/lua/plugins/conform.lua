return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      bzl = { "buildifier" },
      java = { "google-java-format" },
      markdown = { "dprint" },
      toml = { "taplo" },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-s", "-i", "2", "-ci", "-bn" },
      },
    },
    -- log_level = vim.log.levels.DEBUG,
  },
}
