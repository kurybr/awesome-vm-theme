local function close_window (client) client:kill() end
local function fixTop (client) client.ontop = not client.ontop end
local function setFullscreen(client) client.fullscreen = not client.fullscreen c:raise() end
local function toggleScreen(client) client:move_to_screen() end

local function setMinimize(client)
	-- The client currently has the input focus, so it cannot be
	-- minimized, since minimized clients can't have the focus.
	client.minimized = true
end

local function setMaximize (client)
	client.maximized = not client.maximized
	client:raise()
end


return {
	close_window = close_window,
	fixTop = fixTop,
	setFullscreen = setFullscreen,
	toggleScreen = toggleScreen,
	setMinimize = setMinimize,
	setMaximize = setMaximize
}