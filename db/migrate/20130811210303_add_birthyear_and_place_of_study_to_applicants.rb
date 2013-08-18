class AddBirthyearAndPlaceOfStudyToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :birthyear, :string
    add_column :applicants, :place_of_study, :string
  end
end
