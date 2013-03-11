# -*- coding: utf-8 -*-
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
    @points_sorted = User
      .joins(:what_am_is)
      .select("users.id, given_name, family_name, COUNT(*) AS score")
      .where("what_am_is.played = 1 AND answer = 1")
      .group("users.id")
      .order("score DESC")
      .limit(10)

    @best_ratio_sorted = User.find_by_sql(
      "SELECT u_id AS id, given_name, family_name, points, played, ratio
      FROM (
        SELECT derived.u_id, given_name, family_name, SUM(score) as points, SUM(total) AS played, (SUM(score)/SUM(total)*100) AS ratio
        FROM (
          SELECT users.id AS u_id, users.given_name AS given_name, users.family_name AS family_name, Count(*) AS score, 0 as total
          FROM `users`
          INNER JOIN `what_am_is` ON `what_am_is`.`user_id` = `users`.`id`
          WHERE (what_am_is.played = 1 AND answer = 1)
          GROUP BY users.id
          UNION
          SELECT users.id AS u_id, users.given_name AS given_name, users.family_name AS family_name, 0 AS score, Count(*) AS total
          FROM `users`
          INNER JOIN `what_am_is` ON `what_am_is`.`user_id` = `users`.`id`
          WHERE (what_am_is.played = 1)
          GROUP BY users.id
        ) AS derived
        GROUP BY u_id
        ORDER BY ratio DESC
      ) AS final
      WHERE (played > 9)
      LIMIT 10")

    @guessed_sorted = User.find_by_sql(
      "SELECT derived.correct_user_id, SUM(c) as correct, c, u.id, u.given_name, u.family_name
      FROM (
        SELECT *, (COUNT(*)) as c
        FROM what_am_is
        WHERE answer = 1
        GROUP BY guessed_user_id
        UNION
        SELECT *, (-COUNT(*)) as c
        FROM what_am_is
        WHERE answer=0
        GROUP BY guessed_user_id
      ) AS derived
      INNER JOIN users u ON derived.guessed_user_id = u.id
      GROUP By guessed_user_id
      ORDER BY correct DESC
      LIMIT 10")

    @user_games = WhatAmI.where(user_id: current_user.id)
    @points     = @user_games.where(answer: 1).count
    @played     = @user_games.where(played: 1).count
    @ratio      = @points.to_f / @played

    @user_stats = {
      "Poeng" => @points,
      "Antall spill" => @played,
      "Prosent" => @ratio
    }
  end

end
