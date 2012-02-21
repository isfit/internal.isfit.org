class WikiPage < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki_category
  belongs_to :wiki_page
  before_save :sluggify

  def parent_page
    self.wiki_page
  end

  private

  def sluggify
    if self.parent_page
      self.slug = self.parent_page.slug
    else
      self.slug = self.title.parameterize
    end
  end

end
