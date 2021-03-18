local log = hs.logger.new('mymodule','debug')

hs.hotkey.bind({"cmd", "ctrl"}, "R", function()
  log.i("Config reloaded")
  hs.notify.new({title="Hammerspoon", informativeText="Config reloaded"}):send()
end)