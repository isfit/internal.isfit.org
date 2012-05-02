class Participant < ActiveRecord::Base
  set_primary_key 'id'
  belongs_to :country

	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_presence_of :address1
	validates_presence_of :zipcode
	validates_presence_of :city
  validates_inclusion_of :country_id, :in => 1..201, :message => "not selected"
	validates_presence_of :phone
	validates_presence_of :sex,  :message => "must be selected"	
	validates_presence_of :university
	validates_presence_of :field_of_study

  validates_format_of :email,
      			:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
      			:message => 'address is invalid.'
	validates_confirmation_of :email, :message => "address should match confirmation."
	validates_uniqueness_of :email, :message => " address is already in use."

	validates_presence_of :essay1
	validates_presence_of :essay2
	validates_length_of :essay1, :maximum=>2500, :message => "Essay 1 too long"
	validates_length_of :essay2, :maximum=>2500, :message => "Essay 2 too long"
	validates_length_of :travel_essay, :maximum=>2000, :message => "Travel essay too long"

  validates :essay1, :length => {
    :maximum   => 260,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => " too long, maximum 250 words"
    }

  validates :essay2, :length => {
    :maximum   => 260,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => "too long, maximum 250 words"
    }

	validates_presence_of :birthdate, :message => "not valid"

	validates_numericality_of :workshop1,:greater_than => 0, :message => " not selected"
	validates_numericality_of :workshop2,:greater_than => 0, :message => "not selected"
  validates_numericality_of :workshop3,:greater_than => 0, :message => "not selected"

	validate :check_workshops
	def check_workshops	 
    errors[:base] << "Pleace choose different workshops" unless (workshop1 != workshop2 and workshop2 != workshop3 and workshop1 != workshop3)
	end	

	validates_presence_of :travel_essay, 
			:if => Proc.new { |n| n.travel_apply > 0 }
	validates_presence_of :travel_amount, 
			:if => Proc.new { |n| n.travel_apply > 0 }
	validates_numericality_of :travel_amount, :less_than => 10000,
			:if => Proc.new { |n| n.travel_apply > 0 },
            :message => "must be a number, less than 10000"

  validates :travel_essay, :length => {
    :maximum   => 210,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => "too long, maximum 200 words"
    }

  validates_presence_of :travel_nosupport_other,
			:if => Proc.new { |n| n.travel_apply > 0 },
      :message => "must be selected"    

  validates_presence_of :travel_nosupport_cancome,
			:if => Proc.new { |n| n.travel_apply > 0 },
      :message => "must be selected"    

end
