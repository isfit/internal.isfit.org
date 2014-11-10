class AccountsMailer < ActionMailer::Base
  default from: "orakel@isfit.org"

  def invoice_mail(due, sum, name, section)
    subject = "[ISFiT] [Incoming invoice] Invoice due #{due} has been generated"
    body = "A new invoice by #{name} at #{section} has been generated. It's due #{due} with an amount of #{sum}."

    mail(to: 'headofaccounting@isfit.no', subject: subject, body: body)
  end

  def voucher_mail(desc, sum, name, to)
    subject = "[ISFiT] Voucher for your gang has been generated"
    test = "A new voucher by #{name} has been generated.\n"

    for i in 1..((desc.size / 2)  )
      test += "Description: " + desc["description#{i}"] + "\nAmount: "  + desc["amount#{i}"].sub(/,/, '.') + "\n"
    end
    test += "\nThe voucher has a total amount of #{sum}"
    recipient = to || 'headofaccounting@isfit.no'
    mail(to: recipient, subject: subject, body: test)
  end

  def travel_mail(desc, sum, name, to)
    subject = "[ISFiT] Travel voucher for your gang has been generated"
    travel_body = "A new travel voucher by #{name} has been generated.\n"

    for i in 1..((desc.size / 3)  )
      travel_body += "Travel route: " + desc["route#{i}"] + "\nMeans of transport: "  +
      desc["means#{i}"] + "\nAmount: " + desc["amount#{i}"].sub(/,/, '.') + "\n"
    end
    travel_body += "\nThe voucher has a total amount of #{sum}"
    recipient = to || 'headofaccounting@isfit.no'
    mail(to: recipient, subject: subject, body: travel_body)
  end

  def invoice_section_mail(desc, sum, name, to)
    subject = "[ISFiT] Invoice for your gang has been generated"
    test = "A new invoice by #{name} has been generated.\n"

    for i in 1..((desc.size / 2)  )
      test += "Description: " + desc["description#{i}"] + "\nAmount: "  + desc["amount#{i}"].sub(/,/, '.') + "\n"
    end
    test += "\nThe invoice has a total amount of #{sum}"
    recipient = to || 'headofaccounting@isfit.no'
    mail(to: recipient, subject: subject, body: test)
  end
end
