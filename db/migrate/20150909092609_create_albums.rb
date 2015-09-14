class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
    t.string :name
    t.boolean :published , :default => true
    t.datetime :release_date
    t.boolean :accepted_by_label
      t.timestamps null: false
    end
  end
end
