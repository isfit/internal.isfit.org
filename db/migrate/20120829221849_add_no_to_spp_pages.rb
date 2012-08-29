class AddFieldsToWhatAmIs < ActiveRecord::Migration
  def change
    add_column :spp_pages, :title_no, :string
    add_column :spp_pages, :ingress_no, :string
    add_column :spp_pages, :body_no, :text
  end
end
