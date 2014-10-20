class TransportResponsible < ActiveRecord::Base
	belongs_to :user
	belongs_to :group

	validates :user_id, presence: true
	validates :user, presence: { message: "does not exist."}
	validates :group, presence: { message: "does not exist."}
	validates :group_id, presence: true
end
