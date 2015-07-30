class RemoveLastVisitFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :last_visit, :date
  end
end
