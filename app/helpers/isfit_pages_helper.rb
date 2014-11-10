module IsfitPagesHelper
  def tab_name id
    if id
      @isfit_tab = IsfitTab.where(id: id).first
      @isfit_tab.name_no
    else
      "No tab assigned"
    end
  end
  def has_weight isfit_page
    has_weight = false
    if isfit_page.tab_weight == -1
      has_weight = false
    else
      has_weight = true
    end
  end
end
