class AddAttendingToArticle < ActiveRecord::Migration
  def change
  	add_column :articles, :attending, :boolean, :default => 0
  end
end
