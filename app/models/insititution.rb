class Insititution < ActiveRecord::Base
	attr_accessible :image,:insititution_name
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	after_create :update_file_path

	def update_file_path
	  self.file_path = "/system/images/#{self.id}/medium/#{self.image_file_name}"
      self.save
	end
end
