class AddPosterToConcerts < ActiveRecord::Migration
	def self.up
		add_attachment :concerts, :poster
	end

	def self.down
		remove_attachment :concerts, :poster
	end
end
