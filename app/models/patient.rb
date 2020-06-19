class Patient < User
   has_many :appointments,:dependent=> :destroy
   
def self.create_patient(user)
  	patient = self.new(user)
    patient.status = true
    if patient.save!
  	   return patient
    else
       return nil
    end
end

end