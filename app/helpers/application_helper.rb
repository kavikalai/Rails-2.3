module ApplicationHelper

	def insititution
		insititution = Insititution.last
		name = insititution.try(:insititution_name)
		image = insititution.try(:file_path)
		return [name,image]
	end
	
end
