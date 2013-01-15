class WhoAmIController < ApplicationController
  load_and_authorize_resource

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

    # current week
    @wk_current = Date.today.cweek
    # current year
    yr_current = Date.today.year

    # start date of current week
    wk_start = Date.commercial(yr_current, @wk_current, 1)
    # end date of current week
    wk_end = Date.commercial(yr_current, @wk_current, 7)
    # first week a Who Am I game was played
    wk_first = WhoAmI.first.created_at.strftime("%W").to_i
    

    ########################################################
    # => FINDING THE USER WITH MOST POINTS FOR EACH WEEK
    ########################################################
    @best_points_weekly = Hash.new

    # Returns all users scores for each week 
    # as [week, user_id]=>points/value
    # sorted at week primary with highest value/points first.
    points_weeks = WhoAmI
      .where("correct_user_id = answer")
      .group("yearweek(created_at, 1)")
      .group(:user_id)
      .order("yearweek_created_at_1 DESC")
      .order("count_all DESC")
      .count
    
    # finds the user with highest points in a week
    points_weeks.each do |ar, value|
      if !@best_points_weekly[ar[0]] #week
        @best_points_weekly[ar[0]] = ar[1],value
      end
    end

    ###########################################################
    # => FINDING THE USER WHICH WAS BEST GUESSED FOR EACH WEEK
    ###########################################################
    @best_guessed_weekly = Hash.new
    guessed_weekly = Hash.new

    # [week, user_id]=>points/value
    guessed_weeks = WhoAmI
      .where("correct_user_id = answer")
      .group("yearweek(created_at, 1)")
      .group(:correct_user_id)
      .order("yearweek_created_at_1 DESC")
      .order("count_all DESC")
      .count

    guessed_weeks.each do |ar, value|
      yr = ar[0].to_s[0..3].to_i
      wk_s = Date.commercial(yr, ar[0].to_s[4..5].to_i, 1)
      wk_e = Date.commercial(yr, ar[0].to_s[4..5].to_i, 7)
      guessed_weekly[ar] = guessed_weeks[ar] / WhoAmI.where("correct_user_id = #{ar[1]}").where(:created_at=>wk_s..wk_e).where(played: true).count.to_f
    end

    # Search through dict with [week, user_id] => ratio
    # and find user with highest ratio for each week.
    guessed_weekly.each do |ar, value |
      if !@best_guessed_weekly[ar[0]] #week
        @best_guessed_weekly[ar[0]] = ar[1], value
      
      elsif @best_guessed_weekly[ar[0]][1] < value
        @best_guessed_weekly[ar[0]] = ar[1], value
      
      end
    end

    ########################################################
    # => HIGHSCORE LIST FOR THIS WEEK
    ########################################################
    
    #most points and most guessed for this week.
    w_most_points =  WhoAmI.where("correct_user_id = answer").where(:created_at=>wk_start..wk_end).group(:user_id).order("count_all DESC").limit(10).count
    w_most_guessed = WhoAmI.where("correct_user_id = answer").where(:created_at=>wk_start..wk_end).group(:correct_user_id).order("count_all DESC").limit(10).count

    #weekly
    best_ratio = Hash.new {|h,k| h[k] = 0} #Which player has the best correct/wrong ratio?
    best_guessed = Hash.new {|h,k| h[k] = 0} #Which player is most guessed correcrly

    w_most_guessed.each do |key,value|
      best_guessed[key] = w_most_guessed[key] / WhoAmI.where("correct_user_id = #{key}").where(:created_at=>wk_start..wk_end).where(played: true).count.to_f
    end

    w_most_points.each do |key,value|
      best_ratio[key] = w_most_points[key].to_f / User.find(key).who_am_is.where(played:true).where(:created_at=>wk_start..wk_end).count
      
    end

    @points_sorted = w_most_points.sort_by {|k,v| v}.reverse
    @best_ratio_sorted = best_ratio.sort_by {|k,v| v}.reverse
    @best_correct_guessed = best_guessed.sort_by {|k,v| v}.reverse

    @user_stats = {
      "Poeng" => WhoAmI.where("correct_user_id = answer").where(:user_id =>current_user.id).count,
      "Antall spill" => WhoAmI.where(:user_id =>current_user.id).count
    }

 
  end
end
