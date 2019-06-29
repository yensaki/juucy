class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.references :movie, index: true
      t.integer :following_distance
      t.timestamps
    end
  end
end
