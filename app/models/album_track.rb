class AlbumTrack < ActiveRecord::Base
	belongs_to :album
	belongs_to :label
end
