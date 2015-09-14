class CreateAlbumTracks < ActiveRecord::Migration
  def up
    create_table :album_tracks do |t|
      t.string :name ,:limit => 70
 		t.references(:label)
 		t.references(:album)
      t.timestamps null: false
    end
    add_index(:album_tracks , :name)
    add_index(:album_tracks,:album_id)
  end
  def down
  	drop_table :album_tracks
  end
end
