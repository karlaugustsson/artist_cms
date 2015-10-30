require "mp3info"
class AlbumTrack < ActiveRecord::Base
	acts_as_list
	belongs_to :album
	has_and_belongs_to_many :featured_artists , :class_name => "MusicGroup"
	
	scope :search , lambda { |search| where("name LIKE ?", "%#{search}%") }
	scope :position_asc , lambda{ order("album_tracks.position ASC")}

	has_attached_file :music_file
	validates_presence_of :name  
	validates_length_of :name ,{in: 1..50}
	validates_attachment :music_file, presence: true,
  		content_type: { content_type: ["audio/mp3", "audio/wav", "audio/wma"] },
  		size: { in: 1..15.megabytes }
  		before_save :get_song_length
def get_song_length
	
	if File.exist?(music_file.path)
		path = music_file.path
	else
		
		path = self.music_file.queued_for_write[:original].path
	end

  	Mp3Info.open(path) do |mp3info|
  		puts music_file
  		self.track_length = Time.at(mp3info.length).utc.strftime("%M:%S")


  	
	end
end
end
