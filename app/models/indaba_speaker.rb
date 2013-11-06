# encoding: utf-8
class IndabaSpeaker < ActiveRecord::Base
	def status_name
    case self.status
    when 1
      "Forkastet"
    when 2
      "På idéstadiet"
    when 3
      "Invitasjon sendt"
    when 4
      "I kontakt, positiv"
    when 5
      "Nesten klar"
    when 6
      "Klar"
    when 7
      "Avslag"
    when 8
      "I kontakt, avventende"
    else
      "Ukjent status"
    end
	end
end
