class Festival < ActiveRecord::Base
  self.primary_key = :id
  has_many :sections
  has_many :groups
  def users
    @users = []
    self.sections.each do |s|
      @users += s.users
    end
    self.groups.each do |g|
      @users += g.users
    end
    return @users
  end

  def self.in_progress
    Festival.find_by(year: CURRENT_FESTIVAL_YEAR)
  end
end
