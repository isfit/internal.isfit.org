class ContactLogUnit < ActiveRecord::Base
  belongs_to :contact_log_status
  has_many :contact_log_people, :dependent => :destroy
  has_many :contact_logs, through: :contact_log_people
end
