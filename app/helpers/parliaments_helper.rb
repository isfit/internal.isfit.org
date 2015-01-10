# encoding: utf-8
module ParliamentsHelper

  def hear_date?(ans)
    case ans
    when 0 then "I forelesning"
    when 1 then "På skolen/studiested"
    when 2 then "Sosiale medier"
    when 3 then "Venner"
    end
  end

  def how_m_year?(ans)
    case ans
    when 0 then "3"
    when 1 then "50"
    when 2 then "243"
    when 3 then "3000"
    when 4 then "55.000"
    when 5 then "102.000"
    end
  end

  def how_corrupt?(ans)
    case ans
    when 0 then "Ikke korrupt"
    when 1 then "Litt korrupt"
    when 2 then "Korrupt"
    when 3 then "Veldig korrupt"
    when 4 then "Ekstremt korrupt"
    end
  end

  def same_exp?(ans)
    case ans
    when 0 then "Ja"
    when 1 then "Nei"
    end
  end

  def evalueted?(ans)
    case ans
    when 0 then "Vurdert"
    else "Ikke Vurdert"
    end
  end




end
