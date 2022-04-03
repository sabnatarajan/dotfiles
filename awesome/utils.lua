-- vi: shiftwidth=2
local M = {}

M.run_lua_code = function ()
  awful.prompt.run {
    prompt       = "Run Lua code: ",
    textbox      = awful.screen.focused().widget_prompt.widget,
    exe_callback = awful.util.eval,
    history_path = awful.util.get_cache_dir() .. "/history_eval"
  }
end

M.view_tag_only = function ()
  local screen = awful.screen.focused()
  local tag = screen.tags[i]
  if tag then
    tag:view_only()
  end
end

M.toggle_tag = function ()
  local screen = awful.screen.focused()
  local tag = screen.tags[i]
  if tag then
    awful.tag.viewtoggle(tag)
  end
end

M.move_to_tag = function ()
  if client.focus then
    local tag = client.focus.screen.tags[i]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end
end


M.toggle_on_tag = function ()
  if client.focus then
    local tag = client.focus.screen.tags[i]
    if tag then
      client.focus:toggle_tag(tag)
    end
  end
end

return M
