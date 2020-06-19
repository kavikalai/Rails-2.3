class User < ActiveRecord::Base
	require 'attr_encrypted'
	attr_encrypted :password, :key => "kavi kalai"
	validates_presence_of :user_name, :address
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :message=>"Please Enter Correct Email Address"
	validates_format_of :contact_no, :with =>  /\d[0-9]\)*\z/ , :message => "Only positive number without spaces are allowed"
  attr_accessor :conform_password
	validates_uniqueness_of :user_name, :email, :message=>"Validation faild"
  before_save :upcase_fields
  validates_length_of :password, :minimum=> 6, :if=> Proc.new { |user| user.password.present? }

 
 
  ###################Call Backs#######################################
  after_create :send_mail_notification
  ####################################################################
  named_scope :active, :conditions => ['status = ?', true]
  named_scope :inactive, :conditions => ['status =?',false]
  
  
  def send_mail_notification
    UserMailer.delay.deliver_sending_mail(self)
  end

  def upcase_fields
   self.user_name = self.user_name.split.collect(&:capitalize).join(' ') if self.user_name && !self.user_name.blank?
  end

  def self.create_user(params)
    @user= "#{params[:user][:type].capitalize}".constantize.send("create_#{params[:user][:type]}",params[:user])
      if @user.present?
        return @user
      else
        return nil
      end
  end

  def role_symbols
    ['Admin','Patient','Doctor'].map do |role|
      a=role.underscore.to_sym
    end
  end
end
