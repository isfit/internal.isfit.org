require 'csv'

module UsersHelper

  def csv_user_list
    CSV.generate(:col_sep => ";") do |csv|
      csv << ["Last name", "First name", "Username", "Cardnumber Samfundet", "Cardnumber NTNU"]
      User.in_festival.all(:select => ["given_name", "family_name", "username", "cardnumber_samfundet", "cardnumber_ntnu"]).each do |user|
        csv << [user.family_name, user.given_name, user.username,
          user.cardnumber_samfundet.to_s.empty? ? "NO" : user.cardnumber_samfundet,
          user.cardnumber_ntnu.to_s.empty? ? "NO" : user.cardnumber_ntnu]
      end
    end
  end

  def get_mail_links(user)
    orgLink = mail_to "#{user.username}@isfit.org"
    if(user.google_apps_username)
      noLink = mail_to "#{user.google_apps_username}@isfit.no"
      noLink + " (" + orgLink + ")".html_safe
    else
      orgLink
    end
  end

end
