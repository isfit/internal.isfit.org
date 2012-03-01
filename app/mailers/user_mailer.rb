class UserMailer < ActionMailer::Base
  def forgot_password_mail(r, p)
    mail(:to => r, :from => "orakel@isfit.org", :subject => "[ISFiT] New Password", :body => "A new password has been generated for you\n\nYour new password: "+p)
  end
end
