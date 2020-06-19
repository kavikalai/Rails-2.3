class DoctorsController < ApplicationController
	before_filter :authenticate_user!
  filter_access_to
	def new
      @appointments = @current_user.appointments.active.all(:include => :patient)
		  render :layout=>"main"
	end

  def find_appointment
      if params[:datetimepicker].present?
        @appointments = @current_user.appointments.active.all(:include=>:patient,:conditions=>["date(appointment_data)=?",params[:datetimepicker].to_date])  
        render '/doctors/new', :layout=>"main"
      else
        render '/doctors/new', :layout=>"main"
        flash[:notice]="Appointment Not there!"
      end
  end

	def create
      @prescription = Prescription.create_prescription(params)
        if @prescription.present?
       	    redirect_to '/doctors/new'
       	    flash[:notice]="Prescription created succesfully"
       	else
       		redirect_to '/doctors/new'
       		flash[:notice]="Prescription not created"
       	end
  end

  def appointment_csv
      @csv = genrate_csv_file(params[:id])
  end
  
  
end
