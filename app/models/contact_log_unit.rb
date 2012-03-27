class ContactLogUnit < ActiveRecord::Base
  has_many :contact_log_people

  def contact_logs
    contact_logs = []
    for cp in contact_log_people
      contact_logs += cp.contact_logs 
    end
    return contact_logs
  end

end
