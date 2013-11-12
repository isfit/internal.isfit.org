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
  def status_color_class
     case self.status
    when 1
      "status-red"
    when 2
      "status-yellow"
    when 3
      "status-dark-yellow"
    when 4
      "status-white"
    when 5
      "status-green"
    when 6
      "status-dark-green"
    when 7
      "status-dark-red"
    when 8
      "I kontakt, avventende"
    else
      "status-null"
    end

  end
end
