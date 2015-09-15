class AlbumTracksMusicGroups < ActiveRecord::Migration
  def up
  	create_table :album_tracks_music_groups ,id: false do |t|
  		t.references(:album_track)
  		t.references(:music_group)
  	end
  	add_reference(:album_tracks_music_groups , ['album_track_id','music_group_id'])
  end
  def down
  	drop_table(:album_tracks_music_groups)
  end
end
