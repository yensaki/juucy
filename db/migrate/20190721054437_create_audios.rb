class CreateAudios < ActiveRecord::Migration[5.2]
  def change
    create_table :audios do |t|
      t.references :movie, index: true
      t.text :words
      t.float :start_time, index: true
      t.float :end_time
      t.float :duration
      t.timestamps
    end
  end
end
