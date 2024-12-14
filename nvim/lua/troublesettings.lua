require("trouble").setup({
  icons = {
    indent = {
      fold_open = " ",
      fold_closed = " ",
    },
    folder_open = "->",
    folder_colsed = "-|",
  },
})

vim.keymap.set("n", "<leader>tt", function()
    require("trouble").toggle("diagnostics")
end)

vim.keymap.set("n", "<leader>tT", function()
  vim.cmd("Trouble diagnostics toggle filter.buf=0")
end)
