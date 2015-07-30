class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :url
      t.text :shortlink

      t.timestamps null: false
    end
  end
end
