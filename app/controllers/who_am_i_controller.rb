require_dependency 'am_i_games/highscorer'

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
    @highscorer = Internal::AmIGames::Highscorer.new(:who_am_is)
    set_weeks
    best_points_weekly
    best_ratio_sorted_this_week
  end

  private
  def best_ratio_sorted_this_week
    weekly_most_points =  WhoAmI
      .where("correct_user_id = answer")
      .where(created_at: @current_week_range)
      .group(:user_id)
      .order("count_all DESC")
      .limit(10)
      .count

    best_ratio = Hash.new {|h,k| h[k] = 0}

    weekly_most_points.each do |key,value|
      games_played = User
        .find(key)
        .who_am_is
        .where(played:true)
        .where(created_at: @current_week_range)
        .count
      best_ratio[key] = weekly_most_points[key].to_f / games_played
    end

    @best_ratio_sorted = best_ratio.sort_by {|k,v| v}.reverse
  end

  def best_points_weekly

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
    points_weeks.each do |week_and_user, points|
      week, user = week_and_user

      unless @best_points_weekly.has_key?(week)
        # order by score so first user in each week is the best
        @best_points_weekly[week] = user, points
      end
    end
  end

  def set_weeks
    @current_week_number = Date.today.cweek
    @current_year = Date.today.year

    @first_day_of_current_week = Date.commercial(@current_year, @current_week_number, 1)
    @last_day_of_current_week  = Date.commercial(@current_year, @current_week_number, 7)

    @first_week_of_gameplay = WhoAmI.first.created_at.to_datetime.cweek

    @current_week_range = @first_day_of_current_week..@last_day_of_current_week
  end
end
