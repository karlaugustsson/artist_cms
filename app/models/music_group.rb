class MusicGroup < ActiveRecord::Base
	belongs_to :artist
	has_and_belongs_to_many :albums
	has_and_belongs_to_many :album_tracks
	validates_presence_of(:name) 
	validates_length_of(:name , { in: 1..60 })
	validates_uniqueness_of(:tag_name)
	validates_length_of(:tag_name , { in: 1..60 })

end
