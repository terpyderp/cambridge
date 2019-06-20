require 'funcs'

local MarathonAX = require 'tetris.modes.marathon_ax'
local Piece = require 'tetris.components.piece'

local History6RollsRandomizer = require 'tetris.randomizers.history_6rolls'

local SurvivalAXGame = MarathonAX:extend()

SurvivalAXGame.name = "Survival AX"
SurvivalAXGame.hash = "SurvivalAX"
SurvivalAXGame.tagline = "Can you clear the time hurdles when the game goes this fast?"


function SurvivalAXGame:new()
	SurvivalAXGame.super:new()

	self.roll_frames = 0
	self.randomizer = History6RollsRandomizer()

	self.section_time_limit = 3600
	self.section_start_time = 0
	self.section_times = { [0] = 0 }
	self.section_clear = false

	self.lock_drop = true
	self.enable_hold = true
	self.next_queue_length = 3
end

function SurvivalAXGame:getSectionTimeLimit()
	return 3600
end

function SurvivalAXGame:getARE()
	    if self.lines < 10 then return 18
	elseif self.lines < 40 then return 14
	elseif self.lines < 60 then return 12
	elseif self.lines < 70 then return 10
	elseif self.lines < 80 then return 8
	elseif self.lines < 90 then return 7
	else return 6 end
end

function SurvivalAXGame:getLineARE()
	return self:getARE()
end

function SurvivalAXGame:getDasLimit()
	    if self.lines < 20 then return 10
	elseif self.lines < 50 then return 9
	elseif self.lines < 70 then return 8
	else return 7 end
end

function SurvivalAXGame:getLineClearDelay()
	    if self.lines < 10 then return 14
	elseif self.lines < 30 then return 8
	else return 5 end
end

function SurvivalAXGame:getLockDelay()
		if self.lines < 10 then return 30
	elseif self.lines < 20 then return 26
	elseif self.lines < 30 then return 24
	elseif self.lines < 40 then return 22
	elseif self.lines < 50 then return 20
	elseif self.lines < 70 then return 16
	else return 15 end
end

function SurvivalAXGame:getGravity()
	return 20
end

return SurvivalAXGame
