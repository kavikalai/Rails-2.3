module ApplicationHelper

	def insititution
			insititution = Insititution.last
			name = insititution.try(:insititution_name)
			path = insititution.try(:file_path)
			return [name,path]
	end
	
end
