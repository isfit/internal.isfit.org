class ContactLogUnit < ActiveRecord::Base
  belongs_to :contact_log_status
  has_many :contact_log_people, :dependent => :destroy
  has_many :contact_logs, through: :contact_log_people
  
  def css_class
    self.contact_log_status ? self.contact_log_status.color_code : "status-null"
  end
end
