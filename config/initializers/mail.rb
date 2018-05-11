if Rails.env.production?
  # mailer
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    authentication: :plain,
    user_name: Rails.application.credentials.SMTP_EMAIL,
    password: Rails.application.credentials.SMTP_PASSWORD
  }
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
else
  ActionMailer::Base.delivery_method = :test
end
