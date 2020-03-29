-- luacheck: ignore awesome
local awesome = awesome

local freedesktop = require('freedesktop')
local awful = require('awful')

local variables 	= require("lib.variables")
local hotkeys_popup = require("awful.hotkeys_popup").widget
					  require("awful.hotkeys_popup.keys")

local terminal = variables.terminal
local editor = variables.editor

local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}

local games = {
    { 'Tibia', os.getenv('HOME') .. '/.bin/tibia/Tibia'}
}

local developer = {
	{ 'VScode', 'code' },
	{ 'Studio 3T', 'Studio-3T'}
}


awful.util.mymainmenu = freedesktop.menu.build({
    before = {
        { "Awesome", myawesomemenu },
        { 'Games', games },
		{ 'Developer', developer },
        -- other triads can be put here
    },
    after = {
        -- other triads can be put here
    }
})