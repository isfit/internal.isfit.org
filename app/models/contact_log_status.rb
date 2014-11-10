class ContactLogStatus < ActiveRecord::Base
  has_many :contact_log_people

  def self.status_selection
    ContactLogStatus.all.collect { |s| [s.status, s.id, :class => "#{s.color_code}"] }
  end
end
