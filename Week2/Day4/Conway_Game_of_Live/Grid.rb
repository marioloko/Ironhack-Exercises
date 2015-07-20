require './Cell.rb'

class Grid
	def initialize size
		@status_grid = create_status_grid size
	end

	def create_status_grid size
		grid = []
		size.times do
			row = []
			size.times do 
				row << Random.rand(2)
			end
			grid << row 
		end
		grid
	end

	def update_grid
		new_grid = []
		@status_grid.each_with_index do |row, y_index|
			new_row = []
			row.each_with_index do |element, x_index|
				new_row << update_cell(y_index, x_index)
			end
			new_grid << new_row
		end
		@status_grid = new_grid
	end
	
	def update_cell index_y, index_x
		updated_cell =	Cell.new(@status_grid[index_y][index_x], get_neighbours(index_y,index_x))
		updated_cell.regenerate
	end
		

	def get_neighbours position_y, position_x
		neighbours = []
		for current_y in (position_y-1)..(position_y+1)
			for current_x in (position_x-1)..(position_x+1)
				if inside_limits?(current_y) && inside_limits?(current_x)
					if current_y != position_y || current_x != position_x
						neighbours << @status_grid[current_y][current_x]	
					end
				end
			end
		end	
		neighbours
	end		

	def inside_limits? coordinate
		(coordinate < @status_grid.size && coordinate >= 0) ? true : false
	end

	def print_grid
		@status_grid.each do |row|
			row.each do |element|
				print element.to_s + " "
			end
			puts 
		end
		puts 
	end
end
