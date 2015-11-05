require 'file_size_validator'
class Album < ActiveRecord::Base
   has_many :album_label_relation
  has_many :labels  ,:through => :album_label_relation , :dependent => :destroy
	
	has_and_belongs_to_many :music_groups
	has_many :album_tracks

	attr_accessor :album_art_cache , :full_path_album_art

 
	mount_uploader :album_art, AlbumArtUploader

  scope :search , lambda { |search| where("albums.name LIKE ?", "%#{search}%") }
  scope :published , lambda { where("albums.published = 1") }
  scope :release_date_asc , lambda { order("albums.release_date ASC") }
    scope :release_date_desc , lambda { order("albums.release_date DESC") }
  scope :accepted_by_label , lambda { where("albums.accepted_by_label = 1") }
  
	validates :album_art, 
    :file_size => { 
      :maximum => 0.5.megabytes.to_i 
    }
    validates :release_date,
          date: { after: Proc.new { Time.now - 120.year},
                  before: Proc.new { Time.now + 1.year } }
    # validate :collaborating_artists, :find_artists
    validates_presence_of(:label_ids)
    validates_presence_of(:name) 

    after_destroy :remove_album_art_directory
def remove_album_art_directory

    FileUtils.remove_dir("#{Rails.root}/public/uploads/album/album_art/#{id.to_s}", :force => true)
end

def order_by_release_date
 return Album.release_date_asc
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
