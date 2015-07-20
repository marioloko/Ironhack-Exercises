require './Grid.rb'

class GameOfLife
	def initialize
		@grid = Grid.new(8)
	end
	
	def run_game
		while true
			system "clear"
			@grid.print_grid
			@grid.update_grid
			sleep 1
		end
	end
end
		
GameOfLife.new.run_game
