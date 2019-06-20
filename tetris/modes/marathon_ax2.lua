require 'funcs'

local MarathonAX = require 'tetris.modes.marathon_ax'
local Piece = require 'tetris.components.piece'

local History6RollsRandomizer = require 'tetris.randomizers.history_6rolls'

local MarathonAX2Game = MarathonAX:extend()

MarathonAX2Game.name = "Marathon AX2"
MarathonAX2Game.hash = "MarathonAX2"
MarathonAX2Game.tagline = "Can you clear the time hurdles when the game goes this fast?"


function MarathonAX2Game:new()
	MarathonAX2Game.super:new()

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

function MarathonAX2Game:getGravity()
		if self.lines < 10 then return 84/256
	elseif self.lines < 20 then return 1/2
	elseif self.lines < 30 then return 1
	elseif self.lines < 40 then return 2
	elseif self.lines < 50 then return 3
	elseif self.lines < 60 then return 4
	elseif self.lines < 70 then return 5
	else return 20 end
end

return MarathonAX2Game
