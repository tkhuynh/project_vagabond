class Post < ActiveRecord::Base
	
	extend FriendlyId
	friendly_id :title, use: :slugged

	belongs_to :user
	belongs_to :city
	has_attached_file :photo, styles: { large: "600x600"}
	validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
