class ChangedAnswerToIntegerInWhoAmI < ActiveRecord::Migration
  def up
    change_table :who_am_is do |t|
      t.change :answer, :integer
    end
  end

  def down
    change_table :who_am_is do |t|
      t.change :answer, :boolean
    end
  end
end
