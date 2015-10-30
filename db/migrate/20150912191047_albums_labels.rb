class AlbumsLabels < ActiveRecord::Migration
  def up
    create_table :albums_labels do |t|
      t.integer :allowed_publish , :limit => 1
      t.references(:album)
      t.references(:label)
    end
    add_reference(:albums_labels , ['album_id','label_id', "allowed_publish"])
  end
  def down
    drop_table(:albums_labels)
  end
end
