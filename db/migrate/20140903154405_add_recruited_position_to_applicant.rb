class AddRecruitedPositionToApplicant < ActiveRecord::Migration
  def change
  	add_column :applicants, :recruited_position_id, :integer
  end
end
