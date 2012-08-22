class WhatAmIController < ApplicationController
  def game
    @users = User.random(2013,4)
    correct_id = @users[Random.rand(@users.length)].id
    @whatGame = WhatAmI.new(
                            :played => false,
                            :correct_user_id => correct_id,
                            :user_1_id => @users[0].id,
                            :user_2_id => @users[1].id,
                            :user_3_id => @users[2].id,
                            :user_4_id => @users[3].id)
    @whatGame.save
    if request.post?
      @prevGame = WhatAmI.find(params[:whatGame])
      @prevGame.played = true
      @prevGame.guessed_user_id = params[:user_id]
      if @prevGame.guessed_user_id == @prevGame.correct_user_id
        @prevGame.answer = true
        @user_name = params[:user_name]
      else
        @prevGame.answer = false
      end
      @prevGame.save
    end
  end 

  def highscore

  end

end
