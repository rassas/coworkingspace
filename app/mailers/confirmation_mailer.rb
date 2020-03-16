class ConfirmationMailer < ApplicationMailer

  def confirmation_instructions(request)
    @request = request
    mail(to: request.email, subject: "Instructions de confirmation")
  end

  def reconfirmation_instructions(request)
    @request = request
    mail(to: request.email, subject: "Instructions de reconfirmation")
  end
end
