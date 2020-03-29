local awful = require("awful")
              require("awful.autofocus")
local gears = require("gears")
local lain  = require("lain")
local dpi   = require("beautiful.xresources").apply_dpi

local wibox = require("wibox")

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility



local theme = {}

theme.dir = os.getenv('HOME') .. '/.config/awesome/theme'
theme.wallpaper = theme.dir .. '/wall.png'

theme.font                                      = "Terminus 8"

-- theme.taglist_font                              = "Icons 10"
theme.fg_normal                                 = "#D7D7D7"
theme.fg_focus                                  = "#F6784F"
theme.bg_normal                                 = "#060606"
theme.bg_focus                                  = "#060606"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#2A1F1E"
theme.border_width                              = dpi(1)
theme.border_normal                             = "#0E0E0E"
theme.border_focus                              = "#F79372"
theme.taglist_fg_focus                          = "#F6784F"
theme.taglist_bg_focus                          = "#060606"
theme.tasklist_fg_focus                         = "#F6784F"
theme.tasklist_bg_focus                         = "#060606"
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(130)

theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"

theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 0
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"


awful.util.tagnames   = {
	"Screen 1",
	"Screen 2",
	"Screen 3",
	"Screen 4",
	"Screen 5"
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