class Userprofile < ApplicationRecord
	mount_uploader :profile_image, AvatarUploader
	belongs_to :user
end
