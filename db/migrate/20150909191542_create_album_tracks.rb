class CreateAlbumTracks < ActiveRecord::Migration
  def up
    create_table :album_tracks do |t|
      t.string :name ,:limit => 70
      t.integer :position
      t.string :track_length, :limit => 20
 		t.references(:album)
      t.timestamps null: false

    end
    add_attachment :album_tracks, :music_file 
    add_index(:album_tracks ,:name)
    add_index(:album_tracks,:album_id)
    
  end
  def down
    remove_attachment :album_tracks, :music_file
  	drop_table :album_tracks
    FileUtils.remove_dir("#{Rails.root}/public/uploads/album", :force => true)
    FileUtils.remove_dir("#{Rails.root}/public/uploads/tmp", :force => true)
    FileUtils.remove_dir("#{Rails.root}/public/system", :force => true)
  end
end
