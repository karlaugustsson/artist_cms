class CreateArtistActivationCodes < ActiveRecord::Migration
  def change
    create_table :artist_activation_codes do |t|
      t.string :code, :limit => 50
      t.references(:artist)
      t.timestamps null: false
    end

    add_index("artist_activation_codes", "artist_id" ,:unique => true )
    end
end
