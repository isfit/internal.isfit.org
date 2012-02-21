class WikiCategory < ActiveRecord::Base

  before_save :sluggify

  private

  def sluggify
    self.slug = self.title.parameterize
  end
end
