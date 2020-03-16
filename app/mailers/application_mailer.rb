class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("SMTP_MAIL_FROM") { "mail@dev.com" }
  layout 'mailer'
end
