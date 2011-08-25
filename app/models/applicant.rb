class Applicant < ActiveRecord::Base
  #set_primary_key 'id'
  belongs_to :first_position, :class_name => 'Position', :foreign_key => 'position_id_1'
  belongs_to :second_position, :class_name => 'Position', :foreign_key => 'position_id_2'
  belongs_to :third_position, :class_name => 'Position', :foreign_key => 'position_id_3'

#  def groups
#    Group.where("#{first_position.group_id} = id OR #{second_position.group_id} = id OR #{third_position.group_id} = id")
#  end
#  scope :akkur, lambda { |range| 
#    joins("JOIN groups g1 ON g1.id = #{first_position.group_id}, JOIN groups g2 ON g2.id = #{second_position.group_id}, JOIN groups g3 ON g3.id =  #{third_position.group_id}").where("g1.id = #{user.position.group_id} OR g2.id "
  
  def self.applicants_in_same_group(user)
    applicants = Applicant.all
    app = Array.new
    applicants.each do |a|
      found = false
      a.first_position.groups.each do |f|
        if user.groups.include?(f)
          found = true
        end
      end
      if a.second_position
        a.second_position.groups.each do |f|
          if user.groups.include?(f)
            found = true
          end
        end
      end
      if a.third_position
        a.third_position.groups.each do |f|
          if user.groups.include?(f)
            found = true
          end
       end
      end
      if found
        app << a
      end
    end
    return app
  end

   # where("#{Position.find(self.position_id_1).groups.first.id} = #{user.positions.first.groups.first.id} OR #{Position.find(position_id_2).group_id} = #{user.position.group_id} OR #{Position.find(position_id_3).group_id} = #{user.position.group_id}")
 # end
end
