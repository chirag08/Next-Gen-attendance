class Student < ActiveRecord::Base
	has_many :faces, dependent: :destroy
	has_attached_file :photo,
						:url  => "/assets/students/:id/:style/:basename.:extension",
	                  :path => ":rails_root/public/assets/students/:id/:style/:basename.:extension"


	validates_attachment :photo, presence: true,
  						content_type: { content_type: "image/jpeg" }

end
