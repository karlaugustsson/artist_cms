class AlbumLabelRelation < ActiveRecord::Base
belongs_to :album
belongs_to :label

scope :label_owner , lambda{|label| where("album_label_relations.label_id = #{label}").first}
scope :has_yet_to_be , lambda{ where("album_label_relations.allowed_publish IS NULL")}
before_destroy :send_mails_to_artist_about_label_destroy

 def send_mails_to_artist_about_label_destroy
 	  mail_list = []
 	  puts self.album

      @album = Album.find(self.album_id)
      @album.published = false
      
      
      @album.music_groups.each do |m| 
        @artist = MusicGroup.find(m.id).artist
        
        if !mail_list.include?(@artist.id)
            ArtistMailer.send_message_about_unpublish(@artist,@album.labels.find(self.label_id)).deliver_later
            mail_list.push(@artist.id)
        end

      end
      @album.save()
    
end
end
