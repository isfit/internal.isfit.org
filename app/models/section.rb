class Section < ActiveRecord::Base
  self.primary_key = :id
  has_many :groups
  belongs_to :festival

  def users
    @users = []
    self.groups.each do |g|
      @users += g.users
    end
    return @users
  end

  def name
    locale = I18n.locale.to_s
    locale = 'no' if locale.eql?('nb')
    self.send"#{__method__}_#{locale}"
  end
end
