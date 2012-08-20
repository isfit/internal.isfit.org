class WhoAmIController < ApplicationController
  def index
  end

  def game
    @users = User.random.where("facebook_id IS NOT NULL")
    @user1 = @users[0]
    @user2 = @users[1]
    @user3 = @users[2]
    @user4 = @users[3]
    @random_number = Random.new.rand(4)
    @correct_user = @users[@random_number]

    @session = WhoAmI.new
    @session.user1_id = @users[0].id
    @session.user2_id = @users[1].id
    @session.user3_id = @users[2].id
    @session.user4_id = @users[3].id
    @session.correct_user_id = @correct_user.id
    @session.save
  end

  def feedback
    @session.correct_user_id 
  end

  def highscore
  end
end
