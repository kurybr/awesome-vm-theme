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

mytextclock.font = 'Terminus 8'

lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Terminus 8",
        fg   = '#aaaaaa',
        bg   = '#050505dd'
    }
})

return {
    icon = clockicon,
    text = mytextclock,
}