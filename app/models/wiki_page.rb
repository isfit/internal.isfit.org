class WikiPage < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki_category
  belongs_to :wiki_page
  has_one :child_page, class_name: "WikiPage", foreign_key: "wiki_page_id"
  validates_presence_of :title
  before_save :sluggify

  def parent_page
    self.wiki_page
  end

  def self.find_last_edit
    self.find_by_sql("SELECT * FROM wiki_categories AS w, (#{WikiPage.select("*")
      .from("(#{WikiPage.where(deleted: nil)
      .order("created_at DESC").to_sql}) as p").group("slug").order("slug DESC")
    .to_sql}) AS p WHERE p.wiki_category_id = w.id ORDER BY w.title ASC")
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
