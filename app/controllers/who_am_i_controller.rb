class WhoAmIController < ApplicationController
  def index
  end

  def game
    @users = User.random(2013,4).where("facebook_id IS NOT NULL")
    @correct_user = @users[Random.rand(@users.length)]

    @session = WhoAmI.new
    @session.user1_id = @users[0].id
    @session.user2_id = @users[1].id
    @session.user3_id = @users[2].id
    @session.user4_id = @users[3].id
    @session.correct_user_id = @correct_user.id
    @session.save
    if request.post?
      @obj = WhoAmI.find(params[:session])
      answered_user_id = params[:user_id]
      @g = User.find(params[:user_id])
      puts answered_user_id
      puts @obj.correct_user_id
      if answered_user_id.to_i == @obj.correct_user_id.to_i
        @obj.answer = true
      else 
        @obj.answer = false
      end
      @obj.played = true
      @obj.save
      puts "asdasdasdasdasdasdasd #{@obj.answer}"
    end
  end

  def feedback
    @session.correct_user_id 
  end

  def highscore
  end
end
