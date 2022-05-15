local awful = require("awful")
local wibox = require("wibox")

client.connect_signal("request::titlebars", function(c)
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
	)

    local size_margin = 5;

    awful.titlebar(c, {
        size = 35,
        position = "top",
	}).widget = {
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal, buttons = buttons,
			wibox.container.margin(awful.titlebar.widget.titlewidget(c), 10, 0, 0, 0),
		},
		{
			layout = wibox.layout.fixed.horizontal, buttons = buttons,
		},
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.container.margin(awful.titlebar.widget.minimizebutton  (c),  0, 0, size_margin, size_margin),
			wibox.container.margin(awful.titlebar.widget.maximizedbutton (c),  0, 0, size_margin, size_margin),
			wibox.container.margin(awful.titlebar.widget.closebutton     (c), -2, 6, size_margin, size_margin),
		}
	}
end)
