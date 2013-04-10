# -*- coding: utf-8 -*-

require_dependency 'am_i_games/highscorer'

class WhatAmIController < ApplicationController

  load_and_authorize_resource

  def game
    if request.post?
      @prevGame = WhatAmI.find(params[:whatGame])
      if @prevGame.played != true
        @prevGame.played = true
        @prevGame.guessed_user_id = params[:user_id]
      
        #Was the guess correct?
        if @prevGame.guessed_user_id == @prevGame.correct_user_id
          @prevGame.answer = true
          @user_name = params[:user_name]
          flash[:notice]="Korrekt!"
      
          # Handle multiple correct answsers in the random pool
        elsif User.find(@prevGame.guessed_user_id).positions.last == User.find(@prevGame.correct_user_id).positions.last
          @prevGame.correct_user_id = @guessed_user_id
          @prevGame.answer = true
          flash[:notice]="Korrekt!"
      
          # The guess was wrong.
        else
          @prevGame.answer = false
          correct_user = User.find(@prevGame.correct_user_id)
          flash[:alert]="Feil desverre, "+correct_user.full_name+
                      " ("+correct_user.positions.last.title_no+") var det riktige svaret. Prøv igjen da vel!"
        end
        @prevGame.save
      end
    end

    @users = User.random(2013,4)
    
    correct_id = @users[Random.rand(@users.length)].id
    @current_user_id = current_user.id
    game = WhatAmI.where(user_id: @current_user_id,played: false).order("created_at DESC").limit(1).first

    #If user has a previous unplayed game, give him that one again.
    if game && !(User.find(game.correct_user_id).positions.empty?)
      @whatGame = game
      @users[0] = User.find(@whatGame.user_1_id)
      @users[1] = User.find(@whatGame.user_2_id)
      @users[2] = User.find(@whatGame.user_3_id)
      @users[3] = User.find(@whatGame.user_4_id)
    else 
      @whatGame = WhatAmI.new(
                            :user_id => @current_user_id,
                            :played => false,
                            :correct_user_id => correct_id,
                            :user_1_id => @users[0].id,
                            :user_2_id => @users[1].id,
                            :user_3_id => @users[2].id,
                            :user_4_id => @users[3].id)
      @whatGame.save

    end
  end

  def highscore
    @highscorer = Internal::AmIGames::Highscorer.new(:what_am_is)
  end
end
