class AddFieldsToWhatAmIs < ActiveRecord::Migration
  def change
    add_column :what_am_is, :played, :boolean

  end
end
