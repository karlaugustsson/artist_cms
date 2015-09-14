class Label < ActiveRecord::Base
 belongs_to :music_companies
 has_many :album_tracks
 has_many :albums
end
