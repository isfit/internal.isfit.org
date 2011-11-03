class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.string :title
      t.text :markdown_text
      t.references :user

      t.timestamps
    end
    add_index :presentations, :user_id
  end
end
