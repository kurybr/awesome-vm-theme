local lain = require('lain')
local wibox = require('wibox')

local markup = lain.util.markup




-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock

local clockicon = wibox.widget.imagebox('./clock.png' )
local mytextclock = wibox.widget.textclock(
    markup("#7788af", "%A %d %B ")
    ..
    markup("#ab7367", ">")
    ..
    markup("#de5e1e", " %H:%M ")
)

mytextclock.font = 'Ubuntu 8'

lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = mytextclock.font,
        fg   = '#aaaaaa',
        bg   = '#050505dd',
        -- position = "top_middle",
    }
})

return {
    icon = clockicon,
    text = mytextclock,
}