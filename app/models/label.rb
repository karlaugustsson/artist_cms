class Label < ActiveRecord::Base
 belongs_to :music_companies
 has_many :album_label_relation
 has_many :albums  ,:through => :album_label_relation

 validates_uniqueness_of(:label_name)
 validates_length_of(:label_name , { in: 1..40 })
 validates_presence_of(:label_name)
end
