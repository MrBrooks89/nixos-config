return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    -- The plugin relies on 'nvim-web-devicons' for file icons
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- Configuration options for the yazi.nvim plugin
  },
  keys = {
    {
      "<leader>fy",
      function()
        require("yazi").open()
      end,
      desc = "Open Yazi",
    },
  },
}
