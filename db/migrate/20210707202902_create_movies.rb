class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies, id: :uuid do |t|
      t.string :imdb_id, null: false
      t.string :title, null: false
      t.text :plot, null: false
      t.string :poster, null: false

      t.timestamps
    end
    add_index :movies, :imdb_id, unique: true
  end
end
