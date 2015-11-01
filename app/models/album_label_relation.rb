class AlbumLabelRelation < ActiveRecord::Base
belongs_to :album
belongs_to :label

scope :label_owner , lambda{|label| where("album_label_relations.label_id = #{label}").first}
scope :has_yet_to_be , lambda{ where("album_label_relations.allowed_publish = null")}
end
