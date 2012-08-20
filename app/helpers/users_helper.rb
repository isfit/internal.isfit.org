module UsersHelper

require 'csv'

def csv_user_list
  CSV.generate(:col_sep => ";") do |csv|
        csv << ["Last name", "First name", "Username", "Cardnumber Samfundet"]
    User.in_festival.all(:select => ["given_name", "family_name", "username", "cardnumber_samfundet"]).each do |user|
      if user.cardnumber_samfundet.to_s.empty?
        csv << [user.family_name, user.given_name, user.username]
      else
        csv << [user.family_name, user.given_name, user.username, user.cardnumber_samfundet]
      end
    end
  end
end

end
