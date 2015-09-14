class LabelsMusicCompanies < ActiveRecord::Migration
  def up
  	create_table :labels_music_companies ,id: false do |t|
  		t.references(:label)
  		t.references(:music_company)
  	end
  	add_reference(:labels_music_companies , ['label_id','music_company_id'])
  end
  def down
  	drop_table(:labels_music_companies)
  end
end
