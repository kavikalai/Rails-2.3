class UsersController < ApplicationController
    before_filter :authenticate_user!, :except => [:login, :create, :signin]
    before_filter :find_user, :only=>[:new, :user_update, :destroy, :edit_user]
    before_filter :find_path, :only=>[:signin]
    filter_access_to  :all

    def signin
    	@user = User.new
    	render :layout=> "login"
    end

    def create
        @user = User.create_user(params)
        if @user.present?
        	session[:current_user]=@user
        	flash[:notice]="User created sucessfully"
            redirect_to '/users', :method => :get
        else
        	flash.now[:message] = "somthing went wrong"
        	redirect_to '/'
        end
    end
  
    def login
    	@user=User.find_by_user_name_and_password_and_status(params[:user_name],params[:password],true)
    	if @user.present?
    	   session[:current_user] =@user
           redirect_to '/users', :method => :get
        else
           flash[:message]="user name or password is wrong"
           redirect_to '/'
        end
    end

    def index
        if @current_user.type=='Admin'
         	@users = User.active.all
        end
    	render :layout=>"main"
    end

    def logout
        session.clear
        Rails.cache.clear
        redirect_to '/'    	
    end

    def new        	
        render :layout=>"main"
    end

    def update
        status = params[:user][:status]=='Active' ? true : false
    	@current_user.update_attributes(:password=>params[:user][:password],:contact_no=>params[:user][:contact_no],:address=>params[:user][:address],:status=>status)
        if @current_user.present? and @current_user.status==true
    		redirect_to '/users'
    		flash[:notice]="Updated sucessfully"
    	elsif @current_user.present? and @current_user.status==false
            session.clear
            redirect_to '/'
        else     
    		redirect_to '/new'
    		flash[:notice]="Not Updated"
    	end
    end

    def user_update
        status = params[:user][:status]=='Active' ? true : false
        if @user.update_attributes(:password=>params[:user][:password],:contact_no=>params[:user][:contact_no],:address=>params[:user][:address],:status=>status)
            redirect_to '/users'
            flash[:notice]="Updated sucessfully"
        else
            redirect_to '/new'
            flash[:notice]="Not Updated"
        end
    end
  
    def edit_user
       render new_user_path, :layout => "main"
    end
  
    def destroy
    	if @user.update_attribute(:status=>false)
    		redirect_to '/users'
    		flash[:notice]="User removed sucessfully"
    	else
    		redirect_to '/users'
    		flash[:notice]="User not removed"
    	end
    end

    def admin_list
    	@admins = Admin.active.all
    	if @admins.present?
    		render :layout => "main"
    	else
    		redirect_to '/users'
    		flash[:notice]="Recored not there!"
    	end
    end

    def doctor_list
    	@doctors = Doctor.active.all
    	render :layout =>"main"
    end

    def department
      @departments =Department.all
      render :layout=>"main"
    end

    def create_department
      @department = Department.create!(:name=>params[:department],:created_by=>@current_user)
      if @department.present?
      	redirect_to '/users/department'
      	flash[:notice]="department created sucessfully"
      else
      	redirect_to '/users/department'
      	flash[:notice]="department  not created"
      end
    end

    def delete_department
    	@department = Department.find_by_id(params[:id])
    	if @department.destroy
    		redirect_to '/users/department'
    		flash[:notice]="department deleted sucessfully"
    	else
    		redirect_to 'users/department'
    		flash[:notice]="department not deleted"
    	end
    end

    def assign_department
    	@departments = Department.all
    	@doctors = Doctor.all
    	render :layout=>"main"
    end

    def department_doctor
        @doctor = Doctor.find_by_id(params[:doctor])
        if @doctor.update_attributes(:department_id=>params[:department])
            redirect_to '/users'
            flash[:notice]="Department Assigned Sucessfully"
        else
        	redirect_to '/users/assign_department'
        	flash[:notice]="Department Not Assigned"
        end
    end
    
    def inactive_users
        @users = User.inactive.all
        render '/users/index',:layout=>'main'
    end

    def appointment_status
        @departments = Department.all
        render :layout=>"main"
    end

    def department_wise_appointment
        @appointments = Appointment.all  :include=>[:doctor,:patient],:conditions=>['users.department_id=?',params[:department_id]]
        render '/users/department_wise_appointment'
    end

    def genrate_csv
        @csv = genrate_csv_file(params[:id])   
    end

    def institutions
        @institution = Insititution.new
        @institutions = Insititution.all
        render :layout=>"main"
    end

    def uploads
        @institution = Insititution.new(params[:upload])
        if @institution.save!
            redirect_to '/users'
            flash[:notice]="Insitution Changed Sucessfully"
        else
            redirect_to 'users/institutions'
            flash[:notice]="institution not Changed"
        end
    end
end
