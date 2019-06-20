require 'funcs'

local MarathonAX = require 'tetris.modes.marathon_ax'
local Piece = require 'tetris.components.piece'

local History6RollsRandomizer = require 'tetris.randomizers.history_6rolls'

local MarathonAX3Game = MarathonAX:extend()

MarathonAX3Game.name = "Marathon AX3"
MarathonAX3Game.hash = "MarathonAX3"
MarathonAX3Game.tagline = "Can you clear the time hurdles when the game goes this fast?"


function MarathonAX3Game:new()
	MarathonAX3Game.super:new()

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

function MarathonAX3Game:getGravity()
	return 20
end

return MarathonAX3Game
