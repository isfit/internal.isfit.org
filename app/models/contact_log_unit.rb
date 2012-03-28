class ContactLogUnit < ActiveRecord::Base
  has_many :contact_log_people
  has_many :contact_logs, through: :contact_log_people
end
