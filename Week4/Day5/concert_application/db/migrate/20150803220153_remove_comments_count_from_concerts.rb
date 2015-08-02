class RemoveCommentsCountFromConcerts < ActiveRecord::Migration
  def change
    remove_column :concerts, :comments_count, :integer
  end
end
