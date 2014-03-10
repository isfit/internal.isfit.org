class AccountsMailer < ActionMailer::Base
  default from: "orakel@isfit.org"

  def invoice_mail(due, sum)
    subject = "[ISFiT] [Incoming invoice] Invoice due #{due} has been generated"
    body = "Invoice with an amount of #{sum} due #{due} has been generated."

    mail(to: 'headofaccounting@isfit.no', subject: subject, body: body)
  end
end
