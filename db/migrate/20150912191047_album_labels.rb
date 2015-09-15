class AlbumLabels < ActiveRecord::Migration
  def up
    create_table :album_labels ,id: false do |t|
      t.references(:album)
      t.references(:label)
    end
    add_reference(:album_labels , ['album_id','label_id'])
  end
  def down
    drop_table(:album_labels)
  end
end
