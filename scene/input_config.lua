local ConfigScene = Scene:extend()

ConfigScene.title = "Game Controls"

local menu_screens = {
    KeyConfigScene,
    StickConfigScene
}

function ConfigScene:new()
    self.menu_state = 1
    DiscordRPC:update({
        details = "In settings",
        state = "Changing input config",
        largeImageKey = "settings-input"
    })
end

function ConfigScene:update() end

function ConfigScene:render()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(
		backgrounds["input_config"],
		0, 0, 0,
		0.5, 0.5
    )

    love.graphics.setFont(font_3x5_4)
    love.graphics.print("IN-GAME CONTROLS", 80, 40)

    love.graphics.setFont(font_3x5_2)
    love.graphics.print("Which controls do you want to configure?", 80, 90)

    love.graphics.setColor(1, 1, 1, 0.5)
	love.graphics.rectangle("fill", 75, 118 + 50 * self.menu_state, 200, 33)

    love.graphics.setFont(font_3x5_3)
	love.graphics.setColor(1, 1, 1, 1)
	for i, screen in pairs(menu_screens) do
		love.graphics.printf(screen.title, 80, 120 + 50 * i, 200, "left")
    end
end

function ConfigScene:changeOption(rel)
	local len = table.getn(menu_screens)
	self.menu_state = (self.menu_state + len + rel - 1) % len + 1
end

function ConfigScene:onInputPress(e)
	local had_config = config.input ~= nil
	if e.input == "menu_decide" or (not had_config and e.scancode == "return") then
		playSE("main_decide")
		scene = menu_screens[self.menu_state]()
	elseif e.input == "menu_up" or (not had_config and e.scancode == "up") then
		self:changeOption(-1)
		playSE("cursor")
	elseif e.input == "menu_down" or (not had_config and e.scancode == "down") then
		self:changeOption(1)
		playSE("cursor")
	elseif had_config and e.input == "menu_back" then
		scene = SettingsScene()
	end
end

return ConfigScene
