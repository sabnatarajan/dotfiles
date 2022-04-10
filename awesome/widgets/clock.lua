-- vi: shiftwidth=2

local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local naughty = require('naughty')

local refresh_interval = 1
local is_format_toggled = false
local format_one = "%a, %b %d %H:%M "
local format_two = "%a, %b %d %H:%M:%S "

local clock = wibox.widget.textclock(format_one, refresh_interval)

local toggle_format = function()
  is_format_toggled = not is_format_toggled
  
  if is_format_toggled then
    clock.format = format_two
  else
    clock.format = format_one
  end
end

local buttons = gears.table.join(
  awful.button({}, 3, toggle_format) -- right-click to toggle format
)

clock:buttons(buttons)

return clock
