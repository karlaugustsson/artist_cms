class CreateArtists < ActiveRecord::Migration
	def up
	    create_table :artists do |t|
	      t.string :email , :limit => 200 , :null => false
	      t.string :password_digest
	      t.boolean :activated , :default => 0
	      t.timestamps null: false
	      

	  	
	  	end   
	  	add_index :artists, :email


	end

	def down
	drop_table :artists
	end

end