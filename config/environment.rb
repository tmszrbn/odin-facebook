# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.delivery_method = :smtp
  # host = 'whispering-retreat-66818.herokuapp.com'
  # config.action_mailer.default_url_options = { host: host }

  # ActionMailer::Base.smtp_settings = {
  # :user_name => ENV['SENDGRID_USERNAME'],
  # :password => ENV['SENDGRID_PASSWORD'],
  # :domain => 'yourdomain.com',
  # :address => 'smtp.sendgrid.net',
  # :port => 587,
  # :authentication => :plain,
  # :enable_starttls_auto => true
# }