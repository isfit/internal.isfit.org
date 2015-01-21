class SubscriberMailer < ActionMailer::Base
  def drive_mailer(drive)
    subject = "[ISFiT] Kjøring ved tidspunkt #{drive.start_time} er oppdatert"
    body = "Din kjørebestilling med ID: #{drive.id}, tidspunkt #{drive.start_time} har blitt oppdatert med sjåfør og bil. \n\n Hilsen ISFiT <3"

    mail(to: "#{drive.user.username}@isfit.org", from: 'orakel@isfit.org', subject: subject, body: body)
  end
end