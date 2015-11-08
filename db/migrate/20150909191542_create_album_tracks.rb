class CreateAlbumTracks < ActiveRecord::Migration
  def up
    create_table :album_tracks do |t|
      t.string :name ,:limit => 70
      t.integer :position
      t.string :track_length, :limit => 20
      t.string :music_file_file_name
      t.integer :music_file_file_size
      t.string :music_file_content_type
      t.timestamp :music_file_updated_at
 		t.references(:album)
      t.timestamps null: false

    end

    add_index(:album_tracks ,:name)
    add_index(:album_tracks,:album_id)
    
  end
  def down

  	drop_table :album_tracks
    FileUtils.remove_dir("#{Rails.root}/public/uploads/album", :force => true)
    FileUtils.remove_dir("#{Rails.root}/public/uploads/tmp", :force => true)
    FileUtils.remove_dir("#{Rails.root}/public/system", :force => true)
  end
end
