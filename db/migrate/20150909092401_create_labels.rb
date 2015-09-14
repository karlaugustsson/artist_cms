class CreateLabels < ActiveRecord::Migration
  
  def up
    create_table :labels do |t|
	    t.string :label_name
	    t.integer :music_company_id
	    t.timestamps null: false
      t.references(:music_company)
    end

    add_index(:labels, :music_company_id)
  end

  def down
  	drop_table :labels
end
end