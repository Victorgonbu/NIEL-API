class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.string :name
      t.integer :bpm
      t.text :pcm
      t.boolean :buyable

      t.timestamps
    end
  end
end
