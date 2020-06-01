class User < ActiveRecord::Base
	require 'attr_encrypted'
	attr_encrypted :password, :key => "kavi kalai"
	validates_presence_of :user_name, :address
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :message=>"Please Enter Correct Email Address"
	validates_format_of :contact_no, :with =>  /\d[0-9]\)*\z/ , :message => "Only positive number without spaces are allowed"
  attr_accessor :conform_password
	validates_uniqueness_of :user_name, :email, :message=>"Validation faild"
  #validates_presence_of :password, :with => /^[([a-z]|[A-Z])0-9_-]{6,40}$/, :message=> "must be at least 6 characters and include one number and one letter."

 
 
  ###################Call Backs#######################################
  after_create :send_mail_notification
  ####################################################################
  named_scope :active, :conditions => ['status = ?', true]
  named_scope :inactive, :conditions => ['status =?',false]
  
  def send_mail_notification
    UserMailer.deliver_sending_mail(self)
  end

  def self.create_user(params)
    @user= "#{params[:user][:type].capitalize}".constantize.send("create_#{params[:user][:type]}",params[:user])
      if @user.present?
        return @user
      else
        return nil
      end
  end
end
