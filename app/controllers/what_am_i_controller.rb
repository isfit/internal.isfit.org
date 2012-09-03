# -*- coding: utf-8 -*-
class WhatAmIController < ApplicationController
  def game
    if request.post?
      @prevGame = WhatAmI.find(params[:whatGame])
      @prevGame.played = true
      @prevGame.guessed_user_id = params[:user_id]
      if @prevGame.guessed_user_id == @prevGame.correct_user_id
        @prevGame.answer = true
        @user_name = params[:user_name]
        flash[:notice]="Korrekt!"
      else
        @prevGame.answer = false
        flash[:alert]="Feil desverre, prøv igjen da vel!"
      end
      @prevGame.save
    end

    @users = User.random(2013,4)
    
    correct_id = @users[Random.rand(@users.length)].id
    @current_user_id = current_user.id
    game = WhatAmI.where(user_id: @current_user_id,played: false).order("created_at DESC").limit(1).first

    #If user has a previous unplayed game, give him that one again.
    if game
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
    whatAmIs = WhatAmI.where(played: true)
    points = Hash.new {|h,k| h[k] = 0} #Which player has most correct guesses?
    guessed = Hash.new {|h,k| h[k] = 0} #Which person is easiest to guess?
    played = Hash.new {|h,k| h[k] = 0} #Used to find best played based correct/wrong ratio
    best_ratio = Hash.new {|h,k| h[k] = 0} #Which player has the best correct/wrong ratio?

    whatAmIs.each do |what|
      if what.played == true
        played[User.find(what.user_id)] += 1

        if what.answer == true
          guessed[User.find(what.guessed_user_id)] += 1
          points[User.find(what.user_id)] += 1

          #Using .to_f to get floating point
          best_ratio[User.find(what.user_id)] = points[User.find(what.user_id)].to_f / played[User.find(what.user_id)]
        else
          guessed[User.find(what.guessed_user_id)] -= 1
        end
      end
    end

    #Sorting all descending (highest to lowest)
    @guessed_sorted = guessed.sort_by {|k,v| v}.reverse[0..9]
    @points_sorted = points.sort_by {|k,v| v}.reverse
    @best_ratio_sorted = best_ratio.sort_by {|k,v| v}.reverse
  end

end
