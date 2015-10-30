class AddActivatedFieldToMusicCompanies < ActiveRecord::Migration
  def up
  	add_column :music_companies, :activated , :int , :default => 0
  end

  def down
  	remove_column :music_companies, :activated
  end
end
