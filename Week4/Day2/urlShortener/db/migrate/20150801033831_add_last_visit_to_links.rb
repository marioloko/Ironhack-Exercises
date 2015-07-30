class AddLastVisitToLinks < ActiveRecord::Migration
  def change
    add_column :links, :last_visit, :time
  end
end
