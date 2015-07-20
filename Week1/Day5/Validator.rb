require './Figure.rb'
require './Board.rb'

class Validator
	def initialize board_file 
		@board = Board.new(board_file)
	end

	def check_movement figure_coordinate, new_coordinate
		if valid_coordinate?(figure_coordinate) && valid_coordinate?(new_coordinate)
			@current_figure = get_figure_at figure_coordinate
			final_position_figure = get_figure_at new_coordinate
			return @current_figure.valid_movement? final_position_figure, @board.board_grid
		end
	end

	def get_coordinate coordinate
		CoordinatesConversor.coordinates_to_array coordinate, @board.board_grid.size
	end

	def get_figure_at coordinates
		real_coordinates = get_coordinate coordinates
		figure_name = get_figure_name_at coordinates
		FigureGenerator.get_figure figure_name, real_coordinates
	end

	def get_figure_name_at coordinates
		x_pos = get_coordinate(coordinates)[0]
		y_pos = get_coordinate(coordinates)[1]
		figure_name = @board.board_grid[x_pos][y_pos]
	end

	def valid_coordinate? coordinate
		decrypted_coordinate = get_coordinate coordinate
		coord_x = decrypted_coordinate[0]
		coord_y = decrypted_coordinate[1]
		if ( coord_x >= 0 && coord_x < @board.board_grid.length )
			if (coord_y >= 0 && coord_y < @board.board_grid[0].length )
				return true
			end
		end
	end

	def validate_movement figure_coordinate, new_coordinate
		if check_movement figure_coordinate, new_coordinate
			puts "LEGAL"
		else
			puts "ILEGAL"
		end
	end

	def validate_movement_from_file coordinates_file
		coordinates = CoordinatedReader.new(coordinates_file).get_coordinates
		coordinates.each do |coordinate|
			coord_x = coordinate[0]
			coord_y = coordinate[1]
			validate_movement coord_x, coord_y
		end
	end
end

class CoordinatesConversor
	def self.coordinates_to_array coordinate, max_length
		coordinate_array = []
		coordinate_array << - ( coordinate.last.to_i - max_length ) 
		coordinate_array << ( coordinate.initial.ord - 'a'.ord )
	end
end

class CoordinatedReader
	def initialize coordinates_file
		@coordinates_file = coordinates_file
		@coordinates = []
	end

	def read_coordinates
		@coordinates = []
		rows = IO.read(@coordinates_file).split("\n")
		rows.each do |element|
			@coordinates << element.split(" ")
		end
	end
	
	def get_coordinates
		read_coordinates
		@coordinates
	end
end

#Validator.new("simple_board.txt").validate_movement_from_file("coordinates.txt")
#Validator.new("simple_board.txt").validate_movement "e8", "f6"
Validator.new("complex_board.txt").validate_movement_from_file("complex_movements.txt")
