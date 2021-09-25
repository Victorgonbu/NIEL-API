class CreateGenreTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :genre_tracks do |t|
      t.references :track, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
