class DialogueParticipant < ActiveRecord::Base
  self.primary_key = 'id'
  belongs_to :country

	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_presence_of :address1
	validates_presence_of :zipcode
	validates_presence_of :city
  validates_inclusion_of :country_id, :in => 1..201, :message => "not selected"
	validates_presence_of :phone
  validates_presence_of :nationality
  validates_presence_of :passport
	validates_presence_of :birthdate
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
	validates_presence_of :essay3
	validates_presence_of :essay4
	validates_length_of :essay1, :maximum=>2200, :message => "Essay 1 too long"
	validates_length_of :essay2, :maximum=>2200, :message => "Essay 2 too long"
	validates_length_of :essay3, :maximum=>2200, :message => "Essay 3 too long"
	validates_length_of :essay4, :maximum=>1200, :message => "Essay 4 too long"

  validates :essay1, :length => {
    :maximum   => 310,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => " too long, maximum 300 words"
    }

  validates :essay2, :length => {
    :maximum   => 310,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => "too long, maximum 300 words"
    }

  validates :essay3, :length => {
    :maximum   => 310,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => " too long, maximum 300 words"
    }

  validates :essay4, :length => {
    :maximum   => 160,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => "too long, maximum 150 words"
    }

	validates_presence_of :apply_workshop

end
