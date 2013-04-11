#encoding: utf-8

module Internal
  module AmIGames
    class WhatAmIScorer
      def initialize params_input
        @params = params_input
      end

      def score
        return if prev_game.played?

        prev_game.played = true
        guess = prev_game.guessed_user_id = params[:user_id]
        solution = prev_game.correct_user_id


        if guess == solution
          prev_game.answer = true
        elsif User.find(guess).positions.last == User.find(solution).positions.last
          prev_game.correct_user_id = prev_game.guessed_user_id
          prev_game.answer = true
        else
          prev_game.answer = false
        end

        prev_game.save
      end

      def correct?
        prev_game.answer
      end

      def correct_user
        User.find(prev_game.correct_user_id)
      end

      private
      def prev_game
        @prev_game ||= WhatAmI.find(params[:whatGame])
      end

      def params
        @params
      end
    end
  end
end
