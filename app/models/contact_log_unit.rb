class ContactLogUnit < ActiveRecord::Base
  has_many :contact_log_people, :dependent => :delete_all
  has_many :contact_logs, through: :contact_log_people
end
