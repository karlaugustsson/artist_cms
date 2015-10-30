class CreateMusicCompanies < ActiveRecord::Migration
  def up
    create_table :music_companies do |t|
    t.string :email , :limit => 200 , :null => false
	  t.string :password_digest
    t.timestamps null: false
    t.integer :super_power ,:default => 0
    end
  end

  def down
  	drop_table :music_companies
  end
end
