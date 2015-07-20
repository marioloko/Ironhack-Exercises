class Cell
	def initialize(state, neighbours)
		@state = state # either 1 or 0 for alive or dead
		@neighbours = neighbours # an array that represents the surrounding cells
	end

	def regenerate
		alive_neighbours = @neighbours.reduce(0) { |memo, neighbour| memo += neighbour }
		if @state == 1
			regenerate_alive_cell alive_neighbours
		else 
			regenerate_dead_cell alive_neighbours
		end	
		@state
	end

	def regenerate_alive_cell alive_neighbours
		if alive_neighbours < 2 || alive_neighbours > 3 
			@state = 0
		end
	end

	def regenerate_dead_cell alive_neighbours
		if alive_neighbours == 3
			@state = 1
		end
	end
end
