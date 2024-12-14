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
  print('hi')
    require("trouble").toggle("diagnostics")
end)
