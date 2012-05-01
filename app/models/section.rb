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
end
