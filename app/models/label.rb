class Label < ActiveRecord::Base
 belongs_to :music_companies
 has_many :albums

 validates_uniqueness_of(:label_name)
 validates_length_of(:label_name , { in: 1..40 })
end
