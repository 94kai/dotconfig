-- vim.notify是neovim独有的，它支持被第三方插件覆盖效果
local notify = pRequire("notify")
local cfg = {
  enable = true,
  ---@type number in millionsecond
  timeout = 5000,
  ---@type 'fade' | 'static' | 'slide'
  stages = "fade",
  ---@type  'defalut' | 'minimal' | 'simple'
  render = "minimal",
}

if notify and cfg and cfg.enable then
  notify.setup({
    stages = cfg.stages,
    timeout = cfg.timeout,
    render = cfg.render,
    -- background_colour = "#ff3300"  
  })
  vim.notify = notify
end
