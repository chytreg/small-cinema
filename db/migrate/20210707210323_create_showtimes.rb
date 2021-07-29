class CreateShowtimes < ActiveRecord::Migration[6.1]
  def change
    create_table :showtimes, id: :uuid do |t|
      t.timestamp :starts_at, null: false
      t.decimal :price, null: false
      t.belongs_to(:movie, foreign_key: true, type: :uuid)

      t.timestamps
    end
  end
end
