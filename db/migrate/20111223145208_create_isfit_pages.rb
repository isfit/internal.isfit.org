class CreateIsfitPages < ActiveRecord::Migration
  def change
    create_table :isfit_pages do |t|
      t.string :title_en
      t.string :title_no
      t.text :ingress_en
      t.text :ingress_no
      t.text :body_en
      t.text :body_no
      t.string :tag
      t.boolean :deleted

      t.timestamps
    end
  end
end
