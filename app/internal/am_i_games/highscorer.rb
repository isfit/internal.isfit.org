module Internal
  module AmIGames
    class Highscorer
      attr_reader :game

      def initialize game
        @game = game
      end

      def points_sorted
        User
          .joins(game)
          .select("users.id, given_name, family_name, COUNT(*) AS score")
          .where("#{game.to_s}.played = 1 AND #{correct_condition}")
          .group("users.id")
          .order("score DESC")
          .limit(10)
      end

      def points_sorted_current_week
        @current_week_number = Date.today.cweek
        current_year = Date.today.year
        first_day_of_current_week = Date.commercial(current_year, @current_week_number, 1)
        last_day_of_current_week  = Date.commercial(current_year, @current_week_number, 7)
        first_week_of_gameplay = WhoAmI.first.created_at.to_datetime.cweek


        current_week_range = first_day_of_current_week..last_day_of_current_week
        #game = :what_am_is
        game_class
          .where(correct_condition)
          .where(created_at: current_week_range)
          .group(:user_id)
          .order("count_all DESC")
          .limit(10)
          .count
      end

      private
      def game_class
        game.to_s.singularize.camelize.constantize
      end

      def correct_condition
        # Answer = 1 in What Am I means the game was answered correctly,
        # in Who Am I answer is the user id answered, and we have to compare
        # to the correct user id every time.

        if game.eql? :what_am_is
          "answer = 1"
        elsif game.eql? :who_am_is
          "answer = correct_user_id"
        end
      end
    end
  end
end
