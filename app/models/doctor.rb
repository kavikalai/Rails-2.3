class Doctor < User

  belongs_to :department
  has_many :appointments, :dependent=> :destroy

	def self.create_doctor(user)
  	doctor = self.new(user)
    doctor.status = true
  	if doctor.save!
  	   return doctor
    else
       return nil
    end
  end
  
end