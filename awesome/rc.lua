-- vi: shiftwidth=2
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

local wibox = require("wibox")         -- Widget and layout library
local beautiful = require("beautiful") -- Theme handling library
local naughty = require("naughty")     -- Notification library
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- local modules
require("startup")
local utils = require("utils")

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.font = "Noto Sans 12"
beautiful.useless_gap = 2

-- Setup programs
terminal   = "alacritty --option window.startup_mode=Windowed" -- my alacritty config defaults to "Maximized"
editor     = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
launcher   = "rofi -show"

mod    = "Mod4"
shift  = "Shift"
ctrl   = "Control"
alt    = "Mod1"
space  = "space"

local l = awful.layout.suit
local layouts = { 
  l.tile, 
  l.floating,
  l.fair,
}
awful.layout.layouts = layouts

-- Create a launcher widget and a main menu
awesome_menu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

main_menu = awful.menu({ 
  items = {
    { "awesome", awesome_menu, beautiful.awesome_icon },
    { "open terminal", function() awful.spawn(terminal) end },
    { "firefox", function() awful.spawn("firefox") end } 
  }
})

widget_launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = main_menu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),

  -- mod + left-click on tag to move window to that tag
  awful.button({ mod }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),

  -- right-click on tag to toggle
  awful.button({ }, 3, awful.tag.viewtoggle),

  awful.button({ mod }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),

  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end), -- scroll-up to view next tag
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end) -- scroll-down to view prev tag
)

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, 
  function (c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
      "request::activate",
      "tasklist",
      {raise = true}
      )
    end
  end),
  awful.button({ }, 3, function() awful.menu.client_list({ theme = { width = 500 } }) end),
  awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
  awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

local function set_wallpaper(s)
  awful.spawn.with_shell("feh --bg-fill --randomize ~/.local/share/wallpapers/*.jpg")
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, layouts[1])

  -- Create a promptbox for each screen
  s.widget_prompt = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.widget_layouts = awful.widget.layoutbox(s)
  s.widget_layouts:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))
  -- Create a taglist widget
  s.tag_list = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.task_list = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })
  s.sep_widget = require("widgets.separator")
  s.battery_widget = require("awesome-wm-widgets.battery-widget.battery")
  s.volume_widget = require("awesome-wm-widgets.volume-widget.volume")
  s.cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
  s.net_speed_widget = require("awesome-wm-widgets.net-speed-widget.net-speed")

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      widget_launcher,
      s.tag_list,
      s.widget_prompt,
    },
    {
      layout = wibox.layout.fixed.horizontal,
      -- s.task_list, -- Middle widget
    },
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      s.sep_widget,
      s.cpu_widget{},
      s.sep_widget,
      s.net_speed_widget{},
      s.sep_widget,
      s.volume_widget{device="default"},
      s.sep_widget,
      s.battery_widget({
	font="Noto Sans 12",
	show_current_level=true,
	display_notification=true,
      }),
      s.sep_widget,
      wibox.widget.systray(),
      s.sep_widget,
      require("widgets/clock"),
      s.widget_layouts,
    },
  }
end)

-- Mouse bindings
root.buttons(gears.table.join(
  awful.button({ }, 3, function () main_menu:toggle() end)
))

local groups = {
  awesome = "Awesome",
  c_move = "Client: Move",
  c_focus = "Client: Focus",
  c_size = "Client: Resize",
  client = "Client: Other",
  launcher = "Launcher",
  layout = "Layout",
  screen = "Screen",
  tag = "Tags"
}

-- Key bindings
globalkeys = gears.table.join(
  awful.key({ mod, shift }, "r", awesome.restart, {description = "Reload awesome", group = groups.awesome}),
  awful.key({ mod, shift }, "q", awesome.quit, {description = "Quit Awesome", group = groups.awesome}),
  awful.key({ mod }, "w", function () main_menu:show() end, {description = "Show main menu", group = groups.awesome}),
  awful.key({ mod }, "/", hotkeys_popup.show_help, {description="Show help", group= groups.awesome}),

  awful.key({ mod }, ",", awful.tag.viewprev, {description = "View previous", group = groups.tag}),
  awful.key({ mod }, ".",  awful.tag.viewnext, {description = "View next", group = groups.tag}),
  awful.key({ mod }, "Escape", awful.tag.history.restore, {description = "Go back", group = groups.tag}),

  awful.key({ alt }, ",", function () awful.screen.focus_relative( 1) end, {description = "Focus the next screen", group = groups.screen}),
  awful.key({ alt }, ".", function () awful.screen.focus_relative(-1) end, {description = "Focus the previous screen", group = groups.screen}),

  -- Move, focus and resize clients
  awful.key({ mod }, "j", function () awful.client.focus.global_bydirection("down") end, {description = "Move focus down", group = groups.c_focus}),
  awful.key({ mod }, "k", function () awful.client.focus.global_bydirection("up") end, {description = "Move focus up", group = groups.c_focus}),
  awful.key({ mod }, "h", function () awful.client.focus.global_bydirection("left") end, {description = "Move focus left", group = groups.c_focus}),
  awful.key({ mod }, "l", function () awful.client.focus.global_bydirection("right") end, {description = "Move focus right", group = groups.c_focus}),
  -- Resize windows
  awful.key({ mod, shift }, "j", function () awful.client.incwfact( 0.01) end, {description = "Increase height factor", group = groups.c_size}),
  awful.key({ mod, shift }, "k", function () awful.client.incwfact(-0.01) end, {description = "Decrease height factor", group = groups.c_size}),
  awful.key({ mod, shift }, "h", function () awful.tag.incmwfact(-0.01) end, {description = "Decrease master width factor", group = groups.c_size}),
  awful.key({ mod, shift }, "l", function () awful.tag.incmwfact( 0.01) end, {description = "Increase master width factor", group = groups.c_size}),

  -- Layout manipulation
  awful.key({ mod }, "u", awful.client.urgent.jumpto, {description = "Jump to urgent client", group = groups.client}),
  awful.key({ mod }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    {description = "go back", group = groups.client}
  ),

  -- Standard program
  awful.key({ mod }, "Return", function () awful.spawn(terminal) end, {description = "open the terminal", group = groups.launcher}),
  awful.key({ mod }, space, function () awful.spawn(launcher) end, {description = "Launcher", group = groups.launcher}),
  awful.key({ mod }, "r", function () awful.spawn(launcher) end, {description = "Launcher", group = groups.launcher}),
  -- awful.key({ mod, shift }, "h", function () awful.tag.incnmaster( 1, nil, true) end, {description = "increase the number of master clients", group = "layout"}),
  -- awful.key({ mod, shift }, "l", function () awful.tag.incnmaster(-1, nil, true) end, {description = "decrease the number of master clients", group = "layout"}),
  awful.key({ mod, ctrl }, "j", function () awful.client.swap.byidx(  1) end, {description = "swap with next client by index", group = groups.c_move}),
  awful.key({ mod, ctrl }, "k", function () awful.client.swap.byidx( -1) end, {description = "swap with previous client by index", group = groups.c_move}),
  awful.key({ mod, ctrl }, "h", function () awful.tag.incncol( 1, nil, true) end, {description = "increase the number of columns", group = groups.layout}),
  awful.key({ mod, ctrl }, "l", function () awful.tag.incncol(-1, nil, true) end, {description = "decrease the number of columns", group = groups.layout}),

  awful.key({ mod }, "p", function () awful.layout.inc(1) end, {description = "select next", group = groups.layout}),
  awful.key({ mod, shift }, "space", function () awful.layout.inc(-1) end, {description = "select previous", group = groups.layout}),

  awful.key({ mod, "Control" }, "n",
  function ()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal(
      "request::activate", "key.unminimize", {raise = true}
      )
    end
  end,
  {description = "restore minimized", group = groups.client}),

  -- Media keys
  awful.key({}, "XF86AudioRaiseVolume", function() os.execute("pactl set-sink-volume 0 +5%") end),
  awful.key({}, "XF86AudioLowerVolume", function() os.execute("pactl set-sink-volume 0 -5%") end),
  awful.key({}, "XF86AudioMute", function() os.execute("pactl set-sink-mute 0 toggle") end),

  -- Run lua code
  awful.key({ mod, shift }, "x", utils.run_lua_code, {Description = "lua execute prompt", group = "awesome"})
)

client_keys = gears.table.join(
  awful.key({ mod }, "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = groups.client}
  ),

  awful.key({ mod }, "q", function (c) c:kill() end, {description = "close", group = groups.client}),
  awful.key({ mod, "Control" }, "space",  awful.client.floating.toggle , {description = "toggle floating", group = groups.client}),
  awful.key({ mod, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end, {description = "move to master", group = groups.client}),
  awful.key({ mod, }, "o", function (c) c:move_to_screen() end, {description = "move to screen", group = groups.client}),
  awful.key({ mod, }, "t", function (c) c.ontop = not c.ontop end, {description = "toggle keep on top", group = groups.client}),
  awful.key({ mod, }, "n",
  function (c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end ,
  {description = "minimize", group = groups.client}),
  awful.key({ mod }, "m",
  function (c)
    c.maximized = not c.maximized
    c:raise()
  end ,
  {description = "(un)maximize", group = groups.client}),
  awful.key({ mod, "Control" }, "m",
  function (c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end ,
  {description = "(un)maximize vertically", group = groups.client}),
  awful.key({ mod, "Shift" }, "m",
  function (c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end ,
  {description = "(un)maximize horizontally", group = groups.client})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,

    -- View tag only.
    awful.key({ mod }, "#" .. i + 9, utils.view_tag_only, {description = "View tag #"..i, group = groups.tag}),

    -- Toggle tag display.
    awful.key({ mod, ctrl }, "#" .. i + 9, utils.toggle_tag, {description = "Toggle tag #" .. i, group = groups.tag}),

    -- Move client to tag.
    awful.key({ mod, shift }, "#" .. i + 9, utils.move_to_tag, {description = "Move focused client to tag #"..i, group = groups.tag}),

    -- Toggle tag on focused client.
    awful.key({ mod, ctrl, shift }, "#" .. i + 9, utils.toggle_on_tag, {description = "Toggle focused client on tag #" .. i, group = groups.tag})
  )
end

clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ mod }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ mod }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
-- }}}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
  awful.button({ }, 1, function()
    c:emit_signal("request::activate", "titlebar", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ }, 3, function()
    c:emit_signal("request::activate", "titlebar", {raise = true})
    awful.mouse.client.resize(c)
  end)
  )

  awful.titlebar(c) : setup {
    { -- Left
    awful.titlebar.widget.iconwidget(c),
    buttons = buttons,
    layout  = wibox.layout.fixed.horizontal
  },
  { -- Middle
  { -- Title
  align  = "center",
  widget = awful.titlebar.widget.titlewidget(c)
},
buttons = buttons,
layout  = wibox.layout.flex.horizontal
    },
    { -- Right
    awful.titlebar.widget.floatingbutton (c),
    awful.titlebar.widget.maximizedbutton(c),
    awful.titlebar.widget.stickybutton   (c),
    awful.titlebar.widget.ontopbutton    (c),
    awful.titlebar.widget.closebutton    (c),
    layout = wibox.layout.fixed.horizontal()
  },
  layout = wibox.layout.align.horizontal
}
end)

require("rules")

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.spawn.with_shell("~/.screenlayout/default.sh")
awful.spawn.with_shell("~/.local/bin/keyboard-settings.sh")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("flameshot")
awful.spawn.with_shell("xrdb ~/.config/X11/Xresources")
