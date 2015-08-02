class AddCommentsCountToConcerts < ActiveRecord::Migration
  def change
    add_column :concerts, :comments_count, :integer, :default => 0
		Concert.find_each do |concert|
			concert.update_attribute(:comments_count, user.comments.length)
		end
  end
end
