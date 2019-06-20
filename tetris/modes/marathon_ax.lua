require 'funcs'

local GameMode = require 'tetris.modes.gamemode'
local Piece = require 'tetris.components.piece'

local History6RollsRandomizer = require 'tetris.randomizers.history_6rolls'

local MarathonAXGame = GameMode:extend()

MarathonAXGame.name = "Marathon AX"
MarathonAXGame.hash = "MarathonAX"
MarathonAXGame.tagline = "Can you clear the time hurdles when the game goes this fast?"


function MarathonAXGame:new()
	MarathonAXGame.super:new()

	self.roll_frames = 0
	self.randomizer = History6RollsRandomizer()

	self.section_start_time = 0
	self.section_times = { [0] = 0 }
	self.section_clear = false

	self.lock_drop = true
	self.enable_hold = true
	self.next_queue_length = 3
end

function MarathonAXGame:getSectionTimeLimit()
	if self.lines < 20 then return 7200
	else return 5400 end
end

function MarathonAXGame:getARE()
	return 27
end

function MarathonAXGame:getLineARE()
	return self:getARE()
end

function MarathonAXGame:getDasLimit()
	return 15
end

function MarathonAXGame:getLineClearDelay()
	return 40
end

function MarathonAXGame:getLockDelay()
	return 30
end

function MarathonAXGame:getGravity()
		if self.lines < 10 then return 4/256
	elseif self.lines < 20 then return 12/256
	elseif self.lines < 30 then return 48/256
	elseif self.lines < 40 then return 72/256
	elseif self.lines < 50 then return 96/256
	elseif self.lines < 60 then return 1/2
	elseif self.lines < 70 then return 1
	elseif self.lines < 80 then return 3/2
	elseif self.lines < 90 then return 2
	elseif self.lines < 100 then return 3
	elseif self.lines < 110 then return 4
	elseif self.lines < 120 then return 5
	else return 20 end
end

function MarathonAXGame:advanceOneFrame()
	if self.clear then
		self.roll_frames = self.roll_frames + 1
		if self.roll_frames < 0 then		
			return false
		elseif self.roll_frames > 2968 then
			self.completed = true
		end
	elseif self.ready_frames == 0 then
		if not self.section_clear then
			self.frames = self.frames + 1
		end
		if self:getSectionTime() >= self:getSectionTimeLimit() then
			self.game_over = true
		end
	end
	return true
end

function MarathonAXGame:onLineClear(cleared_row_count)
	if not self.clear then
		local new_lines = self.lines + cleared_row_count
		self:updateSectionTimes(self.lines, new_lines)
		self.lines = math.min(new_lines, 150)
		if self.lines == 150 then
			self.clear = true
			self.roll_frames = -150
		end
	end
end

function MarathonAXGame:getSectionTime()
	return self.frames - self.section_start_time
end

function MarathonAXGame:updateSectionTimes(old_lines, new_lines)
	if math.floor(old_lines / 10) < math.floor(new_lines / 10) then
		-- record new section
		table.insert(self.section_times, self:getSectionTime())
		self.section_start_time = self.frames
		self.section_clear = true
	end
end

function MarathonAXGame:onPieceEnter()
	self.section_clear = false
end

function MarathonAXGame:drawGrid(ruleset)
	self.grid:draw()
end

function MarathonAXGame:getHighscoreData()
	return {
		lines = self.lines,
		frames = self.frames,
	}
end

function MarathonAXGame:drawScoringInfo()
	MarathonAXGame.super.drawScoringInfo(self)

	love.graphics.setColor(1, 1, 1, 1)

	love.graphics.setFont(font_3x5_2)
	love.graphics.print(
		self.das.direction .. " " ..
		self.das.frames .. " " ..
		st(self.prev_inputs)
	)
	love.graphics.printf("NEXT", 64, 40, 40, "left")
	love.graphics.printf("TIME LEFT", 240, 250, 80, "left")
	love.graphics.printf("LINES", 240, 320, 40, "left")

	local current_section = math.floor(self.lines / 10) + 1
	self:drawSectionTimesWithSplits(current_section)

	love.graphics.setFont(font_3x5_3)
	love.graphics.printf(self.lines, 240, 340, 40, "right")
	love.graphics.printf(self.clear and self.lines or self:getSectionEndLines(), 240, 370, 40, "right")

	-- draw time left, flash red if necessary
	local time_left = self:getSectionTimeLimit() - math.max(self:getSectionTime(), 0)
	if not self.game_over and not self.clear and time_left < sp(0,10) and time_left % 4 < 2 then
		love.graphics.setColor(1, 0.3, 0.3, 1)
	end
	love.graphics.printf(formatTime(time_left), 240, 270, 160, "left")
	love.graphics.setColor(1, 1, 1, 1)
end

function MarathonAXGame:getSectionEndLines()
	return math.floor(self.lines / 10 + 1) * 10
end

function MarathonAXGame:getBackground()
	return math.floor(self.lines / 10)
end

return MarathonAXGame
