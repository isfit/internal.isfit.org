#encoding: utf-8
class SubscriberMailer < ActionMailer::Base
  def article_mail(username, article)
    subject = "[ISFiT] [New article] #{article.title} "
    body = "Artikkelen #{article.title} er oppdatert. Gå til https://internal.isfit.org/articles/#{article.id} for å se den nyeste artikkelen \n \n -- \n Hilsen ISFiT <3"

    mail(to: "#{username}@isfit.org", from: 'orakel@isfit.org', subject: subject, body: body)
  end

  def kvitter_mail(username, kvitter)
  subject = "[ISFiT] [New kvitter] #{kvitter.user.username} "
    body = "#{kvitter.user.username} har kvittret! Dette er #{kvitter.user.username}s meningsfulle budskap: #{kvitter.message}. Gå til internal(https://internal.isfit.org) for å se de andre som har kvitret!!! \n \n -- \n Hilsen ISFiT <3"
    mail(to: "#{username}@isfit.org", from: 'orakel@isfit.org', subject: subject, body: body)
  end
end
