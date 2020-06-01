class Patient < User
   validates_uniqueness_of :user_name, :email, :message=>"Validation faild"
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