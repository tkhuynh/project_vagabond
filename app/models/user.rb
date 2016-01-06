class User < ActiveRecord::Base

	extend FriendlyId
	friendly_id :name, use: :slugged

	has_secure_password

	has_many :posts
	has_attached_file :avatar, styles: { medium: "300x300>" }, default_url: "http://www.benchmarkpizzeria.com/wp-content/plugins/special-recent-posts/images/no-thumb.png"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

	validates :name, presence: true
	validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            }
	validates	:password, length: {minimum: 6}

end
