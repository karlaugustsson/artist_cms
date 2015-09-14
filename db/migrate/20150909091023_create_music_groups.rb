class CreateMusicGroups < ActiveRecord::Migration
  def change
    create_table :music_groups do |t|
    	t.string :name , :limit => 50
    	t.boolean :solo_work , :default => false
    	t.datetime :formation_date
    	t.references(:artist)
      t.timestamps null: false
    end
    add_index(:music_groups , :artist_id)
  end
end
