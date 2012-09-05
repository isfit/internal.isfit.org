class WhoAmIController < ApplicationController
  def index
  end

  def game
    @session = WhoAmI.where(user_id: current_user.id).order("created_at DESC").limit(1).first

    if @session==nil || @session.played
      @users = User.random(2013,4).where("facebook_id IS NOT NULL")
      @correct_user = @users[Random.rand(@users.length)]
      @session = WhoAmI.new 
      @session.correct_user_id = @correct_user.id
      @session.user_id = current_user.id
      @session.save
    end

    @correct_user = User.find(@session.correct_user_id)
    
    
    if request.post?
      @obj = WhoAmI.find(params[:session])
      answered_user_id = params[:user_id]
      if answered_user_id.to_i == @obj.correct_user_id.to_i
          @obj.answer = true
      else 
        @obj.answer = false
      end
    @obj.played = true
    @obj.save
    end
  end


  def feedback
    @session.correct_user_id 
  end

  def highscore
    whoAmIs = WhoAmI.where(played: true)
    points = Hash.new {|h,k| h[k] = 0} #Which player has most correct guesses?
    played = Hash.new {|h,k| h[k] = 0} #Used to find best played based correct/wrong ratio
    puts played
    best_ratio = Hash.new {|h,k| h[k] = 0} #Which player has the best correct/wrong ratio?

    whoAmIs.each do |who|
        played[User.find(who.user_id)] += 1

        if who.answer == true
          points[User.find(who.user_id)] += 1

          #Using .to_f to get floating point
          best_ratio[User.find(who.user_id)] = points[User.find(who.user_id)].to_f / played[User.find(who.user_id)]
        end
    end
    @points_sorted = points.sort_by {|k,v| v}.reverse
    @best_ratio_sorted = best_ratio.sort_by {|k,v| v}.reverse
  end
end
