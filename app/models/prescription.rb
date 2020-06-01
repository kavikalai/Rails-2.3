class Prescription < ActiveRecord::Base
	belongs_to :appointment
    validates_presence_of :appointment_id

	def self.create_prescription(params)
		prescription=self.new(params[:prescription])
        prescription.appointment_id = params[:id]
		if prescription.save!
			return prescription
		else
			return prescription=nil
		end
	end
end
