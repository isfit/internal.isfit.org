class AddStudentToHost < ActiveRecord::Migration
  def change
    add_column :hosts, :student, :tinyint
  end
end
