class RemoveCityFromConcerts < ActiveRecord::Migration
  def change
    remove_column :concerts, :city, :string
  end
end
