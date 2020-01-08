class User < ApplicationRecord
    before_save { self.email = email.downcase }
    has_many :items
    validates :username, presence: true, 
              uniqueness: { case_sensitive: false },
              length: { minimum: 3, maximum: 25 }
    validates :fullname, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 105 },
              uniqueness: { case_sensitive: false },
              format: { with: VALID_EMAIL_REGEX }
    has_secure_password

    # validates :avatar, file_size: { less_than: 2.megabytes }
    # mount_uploader :avatar, AvatarUploader
end