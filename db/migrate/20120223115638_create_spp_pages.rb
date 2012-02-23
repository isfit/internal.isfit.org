class CreateSppPages < ActiveRecord::Migration
  def change
    create_table :spp_pages do |t|
      t.string :title_en
      t.string :ingress_en
      t.text :body_en
      t.string :image_text
      t.integer :byline_func_id
      t.string :byline

      t.timestamps
    end
  end
end
