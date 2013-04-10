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
    best_ratio_sorted_this_week
  end

  private
  def best_ratio_sorted_this_week
      @best_ratio_sorted =  WhoAmI
        .joins(:user)
        .select("given_name, family_name, user_id, SUM(correct_user_id = answer) / COUNT(*) AS ratio")
        .where(played: true)
        .where(created_at: @current_week_range)
        .group(:user_id)
        .order("ratio DESC")
        .limit(10)
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
