class String
	def initial
		self[0,1]
	end

	def last
		self[-1,1]
	end
end

module HorizontalMover
	def horizontal_movement next_position
		next_position[0] == @current_position[0] || next_position[1] == @current_position[1]
	end
end

module DiagonalMover
	def diagonal_movement next_position
		coord_x = (next_position[0] - @current_position[0]).abs
		coord_y = (next_position[1] - @current_position[1]).abs
		coord_x == coord_y
	end
end

class Figure
	attr_reader :current_position ,:color

	def initialize figure_name_symbol, color, current_position
		@figure_name_symbol = figure_name_symbol
		@color = color
		@current_position = current_position
	end

	def get_name
		@figure_name_symbol.to_s
	end

	def same_color_figure? color
		@color == color
	end

	def figures_in_between? next_position, board
		coord_x = next_position[0] - @current_position[0]
		coord_y = next_position[1] - @current_position[1]
		normalized_x = normalize_coordinate coord_x
		normalized_y = normalize_coordinate coord_y
		new_coord_x = @current_position[0] + normalized_x
		new_coord_y = @current_position[1] + normalized_y
		while new_coord_x != next_position[0] || new_coord_y != next_position[1]
			if (figure_at_position? new_coord_x, new_coord_y, board)
				return true
			end
			new_coord_x += normalized_x
			new_coord_y += normalized_y
		end
		false
	end

	def normalize_coordinate coordinate
		(coordinate == 0) ? 0 : (coordinate / coordinate.abs)
	end

	def figure_at_position? coordinate_x, coordinate_y, board
		board[coordinate_x][coordinate_y] != "--"
	end

	def valid_movement? final_position_figure, board
		return false
	end
end

class FigureGenerator
	def self.get_figure figure_name, coordinate
		return case figure_name.last
			when "R"
				Rook.new figure_name.to_sym, figure_name.initial, coordinate
			when "N"
				Knight.new figure_name.to_sym, figure_name.initial, coordinate
			when "B"
				Bishop.new figure_name.to_sym, figure_name.initial, coordinate
			when "Q"
				Queen.new figure_name.to_sym, figure_name.initial, coordinate
			when "K" 
				King.new figure_name.to_sym, figure_name.initial, coordinate
			when "P"
				Pawn.new figure_name.to_sym, figure_name.initial, coordinate
			else
				Figure.new figure_name.to_sym, figure_name.initial, coordinate
		end
	end
end
				
class	Rook < Figure
	include HorizontalMover
	def valid_movement? final_position_figure, board
		final_position = final_position_figure.current_position
		figure_color = final_position_figure.color
		horizontal_movement(final_position) && !same_color_figure?(figure_color) && !figures_in_between?(final_position, board)
	end
end

class Knight < Figure
	def valid_movement? final_position_figure, board
		final_position = final_position_figure.current_position
		figure_color = final_position_figure.color
		knight_movement(final_position) && !same_color_figure?(figure_color)
	end
	

	def knight_movement next_position
		cord_x = (next_position[0] - @current_position[0]).abs
		cord_y = (next_position[1] - @current_position[1]).abs
		(cord_x ** 2 + cord_y ** 2) == 5
	end
end

class Bishop < Figure
	include DiagonalMover
	def valid_movement? final_position_figure, board
		final_position = final_position_figure.current_position
		figure_color = final_position_figure.color
		diagonal_movement(final_position) && !same_color_figure?(figure_color) && !figures_in_between?(final_position, board)
	end
end

class Queen < Figure
	include HorizontalMover, DiagonalMover
	def valid_movement? final_position_figure, board
		final_position = final_position_figure.current_position
		figure_color = final_position_figure.color
		queen_movement(final_position) && !same_color_figure?(figure_color) && !figures_in_between?(final_position, board)
	end

	def queen_movement next_position
		diagonal_movement(next_position) || horizontal_movement(next_position)
	end
end

class King < Figure
	def valid_movement? final_position_figure, board
		final_position = final_position_figure.current_position
		figure_color = final_position_figure.color
		king_movement(final_position) && !same_color_figure?(figure_color) && !figures_in_between?(final_position, board)
	end
	
	def king_movement next_position
		coord_x = next_position[0] - @current_position[0]
		coord_y = next_position[1] - @current_position[1]
		coord_x ** 2 + coord_y ** 2 <= 2
	end
end

class Pawn < Figure
	def initialize figure_name_symbol, color, current_position
		super figure_name_symbol, color, current_position
		@direction = (@color == "w") ? 1 : -1
		@initial_position = (@color == "w") ? 6 : 1
	end

	def valid_movement? final_position_figure, board
		final_position = final_position_figure.current_position
		figure_color = final_position_figure.color
		pawn_movement(final_position) && !figures_in_between?(final_position, board) || is_eating_a_figure?(final_position, figure_color)
	end

	def is_eating_a_figure? next_movement, color
		valid_y = (next_movement[1] - @current_position[1]).abs == 1
		valid_x = (next_movement[0] - @current_position[0]) * @direction
		color != '-' && @color != color && valid_y && valid_x
	end

	def pawn_movement next_movement
		valid_coord_y = @current_position[1] == next_movement[1]
		if @current_position[0] == @initial_position	
			valid_coord_x =(@current_position[0] - next_movement[0]) * @direction <= 2
		else 
			valid_coord_x =(@current_position[0] - next_movement[0]) * @direction <= 1
		end
		valid_coord_x && valid_coord_y	
	end
end
