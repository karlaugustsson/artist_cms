require 'file_size_validator'
class Album < ActiveRecord::Base
	has_and_belongs_to_many :labels
	has_and_belongs_to_many :music_group
	has_many :album_tracks

	attr_accessor :album_art_cache 
	mount_uploader :album_art, AlbumArtUploader
	validates :album_art, 
    :file_size => { 
      :maximum => 0.5.megabytes.to_i 
    }
    validates :release_date,
          date: { after: Proc.new { Time.now - 120.year},
                  before: Proc.new { Time.now + 1.year } }
    # validate :collaborating_artists, :find_artists

  after_destroy :remove_album_art_directory
def remove_album_art_directory

    FileUtils.remove_dir("#{Rails.root}/public/uploads/album/album_art/#{id.to_s}", :force => true)
  end

  # def find_artists
  #   if collaborating_artists.blank?
  #     return true
  #   else
  #     string = ""

  #     array = collaborating_artists.split(",")



  #     array.each do |artist|
  #       find = MusicGroup.where(:tag_name => artist).first
  #         if find.nil?
  #           errors[:collaborating_artists] << "music group #{artist} was not found"
  #         end
     
  #     end

  #   end
  # end

end
