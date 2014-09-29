class TransportMailer < ActionMailer::Base
  def change_status_mail(transport_responsible, status)
    statuses = Drive.get_statuses
    stat = statuses[status]
    mail(to: tramsport_responsible.email,
         subject: "Transportbestillingen din er oppdatert. Statusen er nå: #{stat}.")
  end
end
