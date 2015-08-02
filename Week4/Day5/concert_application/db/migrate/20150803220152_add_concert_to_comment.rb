class AddConcertToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :concert, index: true, foreign_key: true
  end
end
