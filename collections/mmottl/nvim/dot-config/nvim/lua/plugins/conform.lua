return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      java = { "google-java-format" },
      bzl = { "buildifier" },
      markdown = { "dprint" },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-s", "-i", "2", "-ci", "-bn" },
      },
    },
    -- log_level = vim.log.levels.DEBUG,
  },
}
