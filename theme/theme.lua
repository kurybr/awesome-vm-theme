local awful = require("awful")
              require("awful.autofocus")
local gears = require("gears")
local lain  = require("lain")
local dpi   = require("beautiful.xresources").apply_dpi

local wibox = require("wibox")


local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme = require('theme.config')


awful.util.tagnames   = {
	"", -- radiation
	"", -- code
	"", -- Rocket
	"", -- Ghost
	"" -- Messages
}

local barheight = dpi( 18 )

--- Update description on this line
local barcolor  = gears.color({
    type  = "linear",
    from  = { barheight, 0 },
    to    = { barheight, barheight },
    stops = {
		{ 0, theme.bg_focus },
		{ 0.8, theme.border_normal },
		{ 1, "#1A1A1A" }
	}
})


local calendar = require('widgets.calendar')



-- Função responsável por atualizar as telas
function theme.at_screen_connect(_screen)

	_screen.quake = lain.util.quake({ app = awful.util.terminal })

	local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(_screen)
	end

	gears.wallpaper.maximized(
		wallpaper,
		_screen,
		true
	)


	-- Tags
    awful.tag(
		awful.util.tagnames,
		_screen,
		awful.layout.layouts
	)

	_screen.mypromptbox = awful.widget.prompt()

	--  ?????
	_screen.mylayoutbox = awful.widget.layoutbox(
		_screen
	)

	_screen.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))


	-- Load Tag screen
	_screen.mytaglist = awful.widget.taglist(
		_screen,
		awful.widget.taglist.filter.all,
		awful.util.taglist_buttons
	)

	-- Show windows on toolbar
	_screen.mytasklist = awful.widget.tasklist(
		_screen,
		awful.widget.tasklist.filter.currenttags,
		awful.util.tasklist_buttons
	)

	_screen.mywibox = awful.wibar(
		{
			position = "top",
			screen = _screen,
			height = dpi(18),
			bg = barcolor
		}
	)

	-- Add widgets to the wibox
    _screen.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            _screen.mytaglist,
			_screen.mypromptbox,
        },
        nil, -- Middle widget
        { -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
			calendar.icon,
			calendar.text,
        },
	}

	_screen.mybottomwibox = awful.wibar({
		position = "bottom",
		screen = _screen,
		border_width = 0,
		height = dpi(20),
		bg = theme.bg_normal,
		fg = theme.fg_normal
	})

	_screen.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
        },
        _screen.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            _screen.mylayoutbox,
        },
    }

end

return theme