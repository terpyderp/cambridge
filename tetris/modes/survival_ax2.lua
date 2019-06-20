require 'funcs'

local MarathonAX2 = require 'tetris.modes.marathon_AX2'
local Piece = require 'tetris.components.piece'

local History6RollsRandomizer = require 'tetris.randomizers.history_6rolls'

local SurvivalAX2Game = MarathonAX2:extend()

SurvivalAX2Game.name = "Survival AX2"
SurvivalAX2Game.hash = "SurvivalAX2"
SurvivalAX2Game.tagline = "Can you clear the time hurdles when the game goes this fast?"


function SurvivalAX2Game:new()
	SurvivalAX2Game.super:new()

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

function SurvivalAX2Game:getSectionTimeLimit()
	return 3600
end

function SurvivalAX2Game:getARE()
	return 6
end

function SurvivalAX2Game:getLineARE()
	return self:getARE()
end

function SurvivalAX2Game:getDasLimit()
	return 7
end

function SurvivalAX2Game:getLineClearDelay()
	return 5
end

function SurvivalAX2Game:getLockDelay()
	return 15
end

function SurvivalAX2Game:getGravity()
	return 20
end

return SurvivalAX2Game
