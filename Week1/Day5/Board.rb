class Board
	attr_reader :board_grid
	def initialize file
		@board_grid = load_board_from_file file
	end

	def load_board_from_file file
		board = []
		board_rows = IO.read(file).split("\n")
		board_rows.each do |row|
			board << row.split
		end
		board
	end

	def print_board
		@board_grid.each do |row|
			row.each do |cell|
				print cell + " "
			end
			puts ""
		end
	end
end
