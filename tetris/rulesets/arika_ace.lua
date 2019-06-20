local ArikaTI = require 'tetris.rulesets.arika_ti'

local ARS = ArikaTI:extend()

ARS.name = "Ace-ARS"
ARS.hash = "ArikaAce"

function ARS:onPieceCreate(piece, grid)
	piece.floorkick = 0
	piece.rotate_counter = 0
	piece.move_counter = 0
end

function ARS:onPieceDrop(piece, grid)
	piece.lock_delay = 0 -- step reset
end

function ARS:onPieceMove(piece, grid)
	piece.lock_delay = 0 -- move reset
	if piece:isDropBlocked(grid) then
		piece.move_counter = piece.move_counter + 1
		if piece.move_counter >= 128 then
			piece.locked = true
		end
	end
end

function ARS:onPieceRotate(piece, grid)
    self:onPieceMove(piece, grid)
end

return ARS