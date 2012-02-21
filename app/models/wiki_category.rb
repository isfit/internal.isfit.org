class WikiCategory < ActiveRecord::Base

  has_many :wiki_pages

  before_save :sluggify

  private

  def sluggify
    self.slug = self.title.parameterize
  end
end
