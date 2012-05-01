class ContactLogStatus < ActiveRecord::Base
	has_many :contact_log_people
end
