class CampaignMailer < ActionMailer::Base
  def validated_mail(story)
  	subject = "[ISFiT] [The global infection] Your story has been validated"
	body = "Your story has now been validated, go to http://www.theglobalinfection.com/stories/#{story.id}" 
	mail(to: "#{story.email}", from: "theglobalinfection@isfit.org", subject: subject, body: body)
  end
end
