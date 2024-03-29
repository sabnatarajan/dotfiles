-- vi: shiftwidth=2

local awful = require("awful")
local beautiful = require("beautiful")

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { 
    rule = { },
    properties = { 
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = client_keys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { 
    rule_any = {
      instance = {
	"DTA",  -- Firefox addon DownThemAll.
	"copyq",  -- Includes session name in class.
	"pinentry",
      },
      class = {
	"Arandr",
	"Blueman-manager",
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
	"Event Tester",  -- xev.
      },
      role = {
	"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
      }
    }, 
    properties = { floating = true }
  },

  -- Add titlebars to normal clients and dialogs
  { 
    rule_any = { type = { "normal", "dialog" } }, 
    properties = { titlebars_enabled = true }
  },

  { rule = { class = "firefox" }, properties = { tag = "web" } },
  { rule_any = { instance = "Alacritty" }, properties = { tag = "term" } },
}
