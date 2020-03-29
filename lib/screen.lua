-- luacheck: ignore screen

local screen = screen

local awful         = require("awful")
                      require("awful.autofocus")

local beautiful     = require("beautiful")
local gears         = require("gears")
local lain          = require("lain")
local dpi           = require("beautiful.xresources").apply_dpi

local theme_path = string.format("%s/.config/awesome/theme/theme.lua", os.getenv("HOME"))

local function set_wallpaper(screen)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(screen)
        end

        gears.wallpaper.maximized(
            wallpaper,
            screen,
            true
        )
    end
end

local function set_arrange(_screen)
    local only_one = #_screen.tiled_clients == 1
    for _, client in pairs(_screen.clients) do
        if only_one and not client.floating or client.maximized then
            client.border_width = 0
        else
            client.border_width = beautiful.border_width
        end
    end
end

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(theme_path)

screen.connect_signal("property::geometry", set_wallpaper)
screen.connect_signal("arrange", set_arrange)

awful.screen.connect_for_each_screen(function(_screen) beautiful.at_screen_connect(_screen) end)
