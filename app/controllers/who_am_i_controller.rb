require_dependency 'am_i_games/highscorer'

class WhoAmIController < ApplicationController
  load_and_authorize_resource

  def index
    redirect_to who_am_i_game_path
  end

  def game
    score_game(params) if request.post?
    @game = get_or_create_new_game

    @players = [ User.find(@game.user1_id),
                 User.find(@game.user2_id),
                 User.find(@game.user3_id),
                 User.find(@game.user4_id), ]
    @correct_user = User.find(@game.correct_user_id)
  end

  def highscore
    @highscorer = Internal::AmIGames::Highscorer.new(:who_am_is)
    @current_week_number = Date.today.cweek
  end

  private
  def score_game params
    game = WhoAmI.find(params[:session])
    answered_user_id = de_hash game, params[:user_hash]
    game.answer = answered_user_id.to_i
    game.played = true
    game.save

    if game.answer.eql? game.correct_user_id
      flash[:notice] = "Det var riktig! Spill videre!"
    else
      flash[:alert] = "Det var feil... Spill videre!"
    end
  end

  def get_or_create_new_game
    old_game = WhoAmI.where(user_id: current_user.id).order("created_at DESC").limit(1).first
    return old_game unless old_game.nil? || old_game.played?
    random = Random.rand(2) + 1

    users = User.random(2015,4).where("profile_picture_file_name IS NOT NULL AND gender LIKE "+random.to_s())

    correct_user = users[Random.rand(users.length)]
    game = WhoAmI.new 
    game.correct_user_id = correct_user.id
    game.user_id = current_user.id
    game.user1_id = users[0].id
    game.user2_id = users[1].id
    game.user3_id = users[2].id
    game.user4_id = users[3].id
    game.save
    game
  end

  def de_hash game, user_hash
    users = [User.find(game.user1_id),
             User.find(game.user2_id),
             User.find(game.user3_id),
             User.find(game.user4_id)]
    users.each { |u| return u.id if u.id_hash.eql?(user_hash)}
  end
end
