class CardCheckerController < ApplicationController
load_and_authorize_resource
  def status
    @users = User.in_festival
    @users.each do |user|
      card = CardChecker.find_by_user_id(user.id)
      if !card
        card = CardChecker.new
        card.user_id = user.id
        card.ntnu_card = false
        card.samfundet_card = false
        card.check_card = false
        card.save
      end
    end
  end


  def update
    if params[:samfundet]
      card = CardChecker.find(params[:samfundet])
      if card.samfundet_card == true
        card.samfundet_card = false
      else
        card.samfundet_card = true
      end
      card.save

    elsif params[:ntnu]
      card = CardChecker.find(params[:ntnu])
      if card.ntnu_card == true
        card.ntnu_card = false
      else
        card.ntnu_card = true
      end
      card.save

    elsif params[:check]
      card = CardChecker.find(params[:check])
      if card.check_card == true
        card.check_card = false
      else
        card.check_card = true
      end
      card.save
    
    end
    render :nothing => true


  end

end

  
