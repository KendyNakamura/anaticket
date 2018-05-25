if Rails.env.production?
  # mailer
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.default_url_options = { host: 'anaticket.heroku.com' }
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.smtp_settings = {
    user_name: ENV['SENDGRID_USERNAME'],
    password: ENV['SENDGRID_PASSWORD'],
    domain: 'heroku.com',
    address: 'smtp.sendgrid.net',
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
else
  ActionMailer::Base.delivery_method = :test
end
