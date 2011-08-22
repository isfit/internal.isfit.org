class Applicant < ActiveRecord::Base
  belongs_to :first_position, :class_name => 'Position', :foreign_key => 'position_id_1'
  belongs_to :second_position, :class_name => 'Position', :foreign_key => 'position_id_2'
  belongs_to :third_position, :class_name => 'Position', :foreign_key => 'position_id_3'


end
