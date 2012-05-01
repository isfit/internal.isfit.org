class ContactLogPerson < ActiveRecord::Base
  belongs_to :contact_log_unit
  belongs_to :contact_log_status
  has_many :contact_logs, :dependent => :delete_all
  # Return full name of user
  def full_name
    "#{first_name} #{last_name}"
  end

end
