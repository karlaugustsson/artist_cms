class AlbumsLabels < ActiveRecord::Migration
  def up
    create_table :albums_labels ,id: false do |t|
      t.references(:album)
      t.references(:label)
    end
    add_reference(:albums_labels , ['album_id','label_id'])
  end
  def down
    drop_table(:albums_labels)
  end
end
