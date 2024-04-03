return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "adrigzr/neotest-mocha",
    },
    opts = function(_, opts)
      local mocha_util = require("neotest-mocha.util")
      local is_mocha_test_file = mocha_util.create_test_file_extensions_matcher(
        { "tests", "spec", "test" },
        { "js", "mjs", "cjs", "jsx", "coffee", "ts", "tsx" }
      )

      table.insert(
        opts.adapters,
        require("neotest-mocha")({
          command = "npm test --",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
          is_test_file = neotest_mocha_is_test_file ~= nil and neotest_mocha_is_test_file or is_mocha_test_file,
        })
      )
    end,
  },
}
