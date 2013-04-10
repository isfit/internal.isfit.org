# -*- coding: utf-8 -*-

require_dependency 'am_i_games/highscorer'
require_dependency 'am_i_games/what_am_i_scorer'
require_dependency 'am_i_games/what_am_i_creator'

class WhatAmIController < ApplicationController
  load_and_authorize_resource

  def game
    score_game(params) if request.post?
    create_new_game
  end

  def highscore
    @highscorer = Internal::AmIGames::Highscorer.new(:what_am_is)
  end

  private
  def score_game params
    scorer = Internal::AmIGames::WhatAmIScorer.new(params)
    scorer.score

    if scorer.correct?
      flash[:notice] = "Korrekt!"
    else
      correct_user = scorer.correct_user
      flash[:alert] = "Feil desverre, #{correct_user.full_name}  " +
                      "#{correct_user.positions.last.title_no} " +
                      "var det riktige svaret. Prøv igjen da vel!"
    end
  end

  def create_new_game
    creator = Internal::AmIGames::WhatAmICreator.new current_user
    @game = creator.game
    @users = creator.users
    @correct_user = creator.correct_user
  end
end
