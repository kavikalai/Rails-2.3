class Admin  < User

  def self.create_admin(user)
    admin = self.new(user)
    admin.status = true
    admin.password ='masteradmin123'
  	if admin.save!
  	   return admin
    else
       return nil
    end
  end


end