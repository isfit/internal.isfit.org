#encoding: utf-8

class TransportMailer < ActionMailer::Base
  def drive_mailer(drive)
    subject = "[oppdrag] Transportoppdrag #{drive.start_time.strftime('%Y-%m-%d %H:%M')} er godkjent"
    body = "Hei." +
    "\n\n" +
		"Transportoppdraget du bestilte med tidspunkt #{drive.start_time.strftime('%Y-%m-%d %H:%M')} er godkjent, og vil bli utført av Transport." +
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

  def drive_rejected_mailer(drive)
  	subject = "[oppdrag] Oppdrag #{drive.start_time.strftime('%Y-%m-%d %H:%M')} er avvist"
  	body = "Oppdraget du bestilte #{drive.start_time.strftime('%Y-%m-%d %H:%M')} er blitt avvist.\n\n" +
  	"Beskrivelse av oppdraget:\n" +
  	"#{drive.description}\n\n" +
  	"Begrunnelse:\n" +
  	"#{drive.comment}\n\n" +
  	"Om du vil at vi skal vurdere oppdraget på nytt, se begrunnelsen over, og oppdater oppdraget med eventuelt manglende informasjon."

  	mail(to: "#{drive.user.username}@isfit.org", from: 'orakel@isfit.org', subject: subject, body: body)
  end
end