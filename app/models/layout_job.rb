class LayoutJob < ActiveRecord::Base
	belongs_to :user

	def publishing
		layoutJobsPublishing = LayoutJobsPublishing.find(self.web_or_print)
		return layoutJobsPublishing.publishing
	end
end
