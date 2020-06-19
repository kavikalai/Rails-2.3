class PatientsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :rand_name, :only=>[:book_appointment]
  filter_access_to
    def new
   	    @doctors = Doctor.all
   	    @departments = Department.all
        render :layout=>"main" 
    end

    def update_department
       	@department = Department.find_by_id(params[:department_id])
       	@doctors=@department.doctors
       	render '/patients/update_department'
    end

    def book_appointment
    	  @appointment = Appointment.create_new_appointment(@name,params,@current_user)
    	  if @appointment==true
    		  redirect_to '/users'
    		  flash[:notice]="Appointment Booked Successfully"
    	  elsif @appointment==false 
          redirect_to 'patients/new'
          flash[:notice]="Appointment Not Booked"
        else
    	    redirect_to '/patients/new'
          flash[:notice]='Doctor Not Available For The Date'	
        end
    end

    def appointment_cancel
        @appointments = @current_user.appointments.active.all(:include=>:doctor)
        render :layout=>"main"
    end

    def destroy
        @appointment = Appointment.find_by_id(params[:id]) 
        if @appointment = Appointment.cancel_appointment(@appointment) 
          redirect_to '/patients/appointment_cancel'
          flash[:notice]='Appointment canceld'
        else
          redirect_to 'patients/appointment_cancel'
          flash[:notice]="Appointment Not canceld"
        end         
    end

    def prescription_list
        @prescriptions = Prescription.all :include =>{:appointment =>[:doctor,:patient]},:conditions=>['appointment_id in (?)',@current_user.appointments.collect(&:id)]
        render :layout=>"main"
    end 

    def prescription_view
      @prescription = Prescription.find_by_id(params[:id])
      respond_to do |format|
        format.pdf  do 
          render :pdf =>  "prescription_view.html.erb",:background=> false, :layout=>'pdf',:encoding=>'TEXT',:orientation=> 'Portrait',
          :page_size=>'A4',:show_as_html=>params.key?('debug'),:disposition=> "inline",
          :footer => { :right => '@2020.kavikalai.All Right Reserved' }         
        end
      end      
    end

end
