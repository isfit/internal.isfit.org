class ContactLog < ActiveRecord::Base
  belongs_to :contact_log_person
  belongs_to :user
end
