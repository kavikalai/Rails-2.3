class ApplicationController < ActionController::Base
  before_filter :set_cache_buster
   
  helper :all 
  protect_from_forgery 
  require 'fastercsv'
 

  def authenticate_user!
  		@current_user = session[:current_user]
      Authorization.current_user = @current_user
      if @current_user.blank?
        redirect_to '/'
      end
  end

  def current_user
    current_user = session[:current_user]
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
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
  
  protected

  def permission_denied
    
    render :file => "#{Rails.root}/public/109.html", :layout=> false
  end
end
