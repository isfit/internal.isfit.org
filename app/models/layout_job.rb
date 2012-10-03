class LayoutJob < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :description, :user_info, :work_title

	def publishing_name
		case self.publishing
		when 1
			"Web"
		when 2
			"Print"
		when 3
			"Both"
		when 4
			"Other"
		end
	end

	def publishing_options
		[
			["Web", 1],
			["Print", 2],
			["Both", 3],
			["Other", 4]
		]
	end

	def status_options
		[
			["New", 1],
			["Open", 2],
			["On hold", 3],
			["Resolved", 4],
			["Rejected", 5],
			["Deleted", 6]
		]
	end

	def status_name
		case self.status
		when 1
			"New"
		when 2
			"Open"
		when 3
			"On hold"
		when 4
			"Resolved"
		when 5
			"Rejected"
		when 6
			"Deleted"
		end
	end

	def status_color
		case self.status
		when 1
			"status_new"
		when 2
			"status_open"
		when 3
			"status_on_hold"
		when 4
			"status_resolved"
		when 5
			"status_rejected"
		when 6
			"status_deleted"
		end
	end
end
