class Group < ActiveRecord::Base
  self.primary_key = :id
  has_and_belongs_to_many :positions
  has_many :layout_jobs
  belongs_to :section
  belongs_to :festival

  def users
    @users = []
    self.positions.each do |p|
      p.users.each do |u|
        if u.id > 1
          @users << u
        end
      end            
    end
    return @users.uniq{|x| x.id}
  end

  def name
    locale = I18n.locale.to_s
    locale = 'no' if locale.eql?('nb')
    self.send"#{__method__}_#{locale}"
  end
end
