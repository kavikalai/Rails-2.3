# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true
#config.eager_load = false
# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false
# config.action_mailer.default_url_options = { :host => "localhost:3000" }
# # Don't care if the mailer can't send
#  ActionMailer::Base.delivery_method = :sendmail
#  ActionMailer::Base.sendmail_settings = {
#    :location => '/usr/sbin/sendmail',
#    :arguments => '-i -t'
#  }
#  ActionMailer::Base.perform_deliveries = true
#  ActionMailer::Base.raise_delivery_errors = true
#  ActionMailer::Base.default_charset = "iso-8859-1"


# ActionMailer::Base.smtp_settings = {
#   :enable_starttls_auto => true,
#   :address => "smtp.gmail.com",
#   :port => 587,
#   :domain => "gmail.com",
#   :authentication => :plain,
#   :user_name => "kavikalai110@gmail.com",
#   :password => "89277737kavikalai!"
# }