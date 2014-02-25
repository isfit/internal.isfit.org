class Account < ActiveRecord::Base
  belongs_to :section

  def name
    self.send"#{__method__}_#{I18n.locale.to_s}"
  end
end
