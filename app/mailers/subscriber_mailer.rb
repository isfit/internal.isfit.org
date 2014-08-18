class subscriber_mailer < ActionMailer::Base
	def article_mail(email, article)
	subject = "[ISFiT] [New article] #{article.name} "
    body = "Artikkelen #{article.name} er oppdatert. Gå til https://internal.isfit.org/article/#{article.id} for å se den nyeste artikkelen "

    mail(to: 'email', from: orakel@isfit.org, subject: subject, body: body)


end