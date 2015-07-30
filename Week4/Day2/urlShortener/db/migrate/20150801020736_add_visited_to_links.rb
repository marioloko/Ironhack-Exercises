class AddVisitedToLinks < ActiveRecord::Migration
  def change
    add_column :links, :visited, :integer
  end
end
