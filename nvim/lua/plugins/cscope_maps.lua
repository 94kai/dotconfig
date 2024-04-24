require("cscope_maps").setup({
	 -- maps related defaults
  disable_maps = false, -- "true" disables default keymaps
  skip_input_prompt = true, -- "true" doesn't ask for input
  prefix = "<leader>c", -- prefix to trigger maps

  -- cscope related defaults
  cscope = {
    -- location of cscope db file
    db_file = "./cscope.out", -- DB or table of DBs
                              -- NOTE:
                              --   when table of DBs is provided -
                              --   first DB is "primary" and others are "secondary"
                              --   primary DB is used for build and project_rooter
                              --   secondary DBs must be built with absolute paths
                              --   or paths relative to cwd. Otherwise JUMP will not work.
    -- cscope executable
    exec = "gtags-cscope", -- "cscope" or "gtags-cscope"
    -- exec = "gtags-cscope", -- "cscope" or "gtags-cscope"
    -- choose your fav picker
    picker = "quickfix", -- "telescope", "fzf-lua" or "quickfix"
    -- size of quickfix window
    qf_window_size = 5, -- any positive integer
    -- position of quickfix window
    qf_window_pos = "bottom", -- "bottom", "right", "left" or "top"
    -- "true" does not open picker for single result, just JUMP
    skip_picker_for_single_result = false, -- "false" or "true"
    -- these args are directly passed to "cscope -f <db_file> <args>"
    db_build_cmd_args = { "-Rbqkv" },
    -- statusline indicator, default is cscope executable
    statusline_indicator = nil,
    -- try to locate db_file in parent dir(s)
    project_rooter = {
      enable = false, -- "true" or "false"
      -- change cwd to where db_file is located
      change_cwd = false, -- "true" or "false"
    },
  }
})
