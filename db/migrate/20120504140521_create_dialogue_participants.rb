class CreateDialogueParticipants < ActiveRecord::Migration
  def change
    create_table :dialogue_participants do |t|

      t.timestamps
    end
  end
end
