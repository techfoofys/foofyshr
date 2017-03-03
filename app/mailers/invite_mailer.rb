# Mailer class for contact us
class InviteMailer < ApplicationMailer
  default from: ' <soumitra@foofys.com>'

  # Contact us message
  def invite(email , name)
    mail(
      to: "#{name} <#{email}>",
      subject: "Foofys - #{name} has contacted us")
  end
end
