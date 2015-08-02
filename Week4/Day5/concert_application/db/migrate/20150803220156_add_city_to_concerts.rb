class AddCityToConcerts < ActiveRecord::Migration
  def change
    add_reference :concerts, :city, index: true, foreign_key: true
  end
end
