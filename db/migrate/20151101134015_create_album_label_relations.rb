class CreateAlbumLabelRelations < ActiveRecord::Migration
  def up
    create_table :album_label_relations do |t|
    	t.integer :allowed_publish , :limit => 1
      t.references(:album)
      t.references(:label)
      t.timestamps null: false
    end
    add_reference(:album_label_relations , ['album_id','label_id', "allowed_publish"])
      
    end


  def down
    drop_table(:album_label_relations)
  end
   end