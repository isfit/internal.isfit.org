class CreatesKvitterHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags_kvitters do |t|
      t.integer :kvitter_id
      t.integer :hashtag_id
    end
  end
end
