# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  require 'fastercsv'
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def authenticate_user!
  		@current_user = session[:current_user]
      if @current_user.blank? 
        redirect_to '/'
      end
  end

  def find_path
    if session[:current_user].present?
      redirect_to '/users'
    end
  end

  def find_user
    @user = User.find_by_id(params[:id])
    if @user.blank?
      redirect_to '/'
    end
  end

  def rand_name(len=4)
    ary = [('0'..'9').to_a, ('a'..'z').to_a, ('A'..'Z').to_a]
    @name = ''
    len.times do
      @name << ary.choice.choice
    end
   return @name
  end

  def genrate_csv_file(id)
    @appointments=Appointment.all :include=>[:patient,:doctor],:conditions=>['id in (?)',id]
      csv_string = FasterCSV.generate do |csv|
          cols = ["AppointmentId", "Appointment Date","Doctor Name", "Doctor Contact No" ,"Patient Name", "Patient Contact No"]
          csv << cols
          @appointments.each do |app|
            csv << [app.appointment_id,app.appointment_data,app.doctor.user_name,app.doctor.contact_no,app.patient.user_name,app.patient.contact_no ]
          end
          @filename = "AppointmentList-#{Time.now.to_date.to_s}.csv"
        end
      send_data(csv_string, :type => 'text/csv; charset=utf-8; header=present', :filename => @filename)
  end

end
