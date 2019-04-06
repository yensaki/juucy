class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :uuid, index: { unique: true }
      t.timestamps
    end
  end
end
