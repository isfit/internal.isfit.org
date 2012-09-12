class WhoAmIController < ApplicationController
  def index
    redirect_to who_am_i_game_path
  end

  def game


    
    if request.post?
      @obj = WhoAmI.find(params[:session])
      answered_user_id = params[:user_id]
      @obj.answer = answered_user_id.to_i
      @obj.played = true
      @obj.save
    end

    @session = WhoAmI.where(user_id: current_user.id).order("created_at DESC").limit(1).first


    if @session==nil || @session.played
      @users = User.random(2013,4).where("profile_picture_file_name IS NOT NULL")

      @correct_user = @users[Random.rand(@users.length)]
      @session = WhoAmI.new 
      @session.correct_user_id = @correct_user.id
      @session.user_id = current_user.id
      @session.user1_id = @users[0].id
      @session.user2_id = @users[1].id
      @session.user3_id = @users[2].id
      @session.user4_id = @users[3].id
      @session.save
    end

    @players = [User.find(@session.user1_id),User.find(@session.user2_id), User.find(@session.user3_id),User.find(@session.user4_id)]

    @correct_user = User.find(@session.correct_user_id)
    
    
    
  end


  def feedback
    @session.correct_user_id 
  end

  def highscore
    mostPoints =  WhoAmI.where("correct_user_id = answer").group(:user_id).order("count_all DESC").limit(10).count
    most_guessed = WhoAmI.where("correct_user_id = answer").group(:correct_user_id).order("count_all DESC").limit(10).count

    best_ratio = Hash.new {|h,k| h[k] = 0} #Which player has the best correct/wrong ratio?
    best_guessed = Hash.new {|h,k| h[k] = 0} 

    most_guessed.each do |key,value|
      best_guessed[key] = most_guessed[key].to_f / WhoAmI.where("correct_user_id = #{key}").where(played: true).count.to_f
    end


    mostPoints.each do |key,value|
      best_ratio[key] = mostPoints[key].to_f / User.find(key).who_am_is.where(played:true).count
      
    end
    @points_sorted = mostPoints.sort_by {|k,v| v}.reverse
    @best_ratio_sorted = best_ratio.sort_by {|k,v| v}.reverse
    @best_correct_guessed = best_guessed.sort_by {|k,v| v}.reverse
  end
end
