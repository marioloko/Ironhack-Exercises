class RemoveConcertIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :concert_id, :integer
  end
end
