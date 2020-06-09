class Appointment < ActiveRecord::Base
	belongs_to :patient
	belongs_to :doctor
	has_one :prescription, :dependent=> :destroy
    
	validates_presence_of :doctor_id, :patient_id, :appointment_data, :appointment_id
    validates_uniqueness_of :appointment_id
    
    after_save :send_notification

    named_scope :active, :conditions => ['status = ?', true] 

    def active_date(app)
    	if app.appointment_data >= Time.now.to_date
    		return true
    	else
    		return false
    	end
    end

	def self.create_new_appointment(name,params,user)
        exits = self.find(:all,:conditions=>['doctor_id=? and date(appointment_data)=?',params[:doctor],params[:time_from].to_date])
        if exits.blank?
            if self.create!(:appointment_id=>name,:doctor_id=>params[:doctor],:patient_id=>user.id,:appointment_data=>params[:time_from].to_date,:status=>true)
                return true
            else
                return false
            end
        else
         return exits
        end
	end

    def self.cancel_appointment(app)
        if app.active_date(app)
        	status=app.update_attributes!(:status=>false)
        	if status
        		app.prescription.delete if app.prescription.present?
        		return true
        	else
        		return false
        	end
        else
           return false
       end
    end

	def send_notification
		UserMailer.delay.deliver_appointment_mail(self)
	end
end
