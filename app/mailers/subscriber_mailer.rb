#encoding: utf-8
class SubscriberMailer < ActionMailer::Base
	def article_mail(username, article)
		subject = "[ISFiT] [New article] #{article.title} "
    body = "Artikkelen #{article.title} er oppdatert. Gå til https://internal.isfit.org/article/#{article.id} for å se den nyeste artikkelen "

    mail(to: "#{username}@isfit.org", from: 'orakel@isfit.org', subject: subject, body: body)
	end
	def kvitter_mail(username, kvitter)
	subject = "[ISFiT] [New kvitter] #{kvitter.user.username} "
    body = "#{kvitter.user.username} har kvittret! Her er den fantastiske meldingen: #{kvitter.message}"
    mail(to: "#{username}@isfit.org", from: 'orakel@isfit.org', subject: subject, body: body)
	end
end
