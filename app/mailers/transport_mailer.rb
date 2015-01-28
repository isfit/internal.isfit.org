#encoding: utf-8

class TransportMailer < ActionMailer::Base
  def drive_mailer(drive)
    subject = "[info] Transportoppdrag #{drive.start_time} er godkjent"
    body = "Hei." +
    "\n\n" +
		"Transportoppdraget du bestilte [dato] [starttidspunkt] er godkjent, og vil bli utført av Transport." +
		"\n\n" +
		"Beskrivelse av det aktuelle oppdraget:" +
		"\n" +
		"#{drive.description}" +
		"\n\n" +
		"Deres kontaktperson for oppdraget:" +
		"#{drive.contact}" +
		"\n\n" +
		"Dersom noen av opplysningene over ikke stemmer, vennligst ta kontakt på board.transportation@isfit.org." +
		"Benytt da klammen [oppdrag] i tittelfeltet! Eks.: \"[oppdrag] Feil tidspunkt ved henting av Johan Møkkerbakken\"."

    mail(to: "#{drive.user.username}@isfit.org", from: 'orakel@isfit.org', subject: subject, body: body)
  end
end