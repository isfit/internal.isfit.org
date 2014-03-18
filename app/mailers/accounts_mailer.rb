class AccountsMailer < ActionMailer::Base
  default from: "orakel@isfit.org"

  def invoice_mail(due, sum, name, section)
    subject = "[ISFiT] [Incoming invoice] Invoice due #{due} has been generated"
    body = "A new invoice by #{name} at #{section} has been generated. It's due #{due} with an amount of #{sum}."

    mail(to: 'headofaccounting@isfit.no', subject: subject, body: body)
  end
end
