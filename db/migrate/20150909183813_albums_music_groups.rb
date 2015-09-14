class AlbumsMusicGroups < ActiveRecord::Migration
  def up
  	create_table :albums_music_groups ,id: false do |t|
  		t.references(:album)
  		t.references(:music_group)
  	end
  	add_reference(:albums_music_groups , ['album_id','music_group_id'])
  end
  def down
  	drop_table(:albums_music_groups)
  end
end
