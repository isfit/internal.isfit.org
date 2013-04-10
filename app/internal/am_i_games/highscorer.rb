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
        current_week_number = Date.today.cweek
        current_year = Date.today.year
        first_day_of_current_week = Date.commercial(current_year, current_week_number, 1)
        last_day_of_current_week  = Date.commercial(current_year, current_week_number, 7)

        current_week_range = first_day_of_current_week..last_day_of_current_week

        @first_day_of_current_week = first_day_of_current_week
        @last_day_of_current_week = last_day_of_current_week

        game_class
          .where(correct_condition)
          .where(created_at: current_week_range)
          .group(:user_id)
          .order("count_all DESC")
          .limit(10)
          .count
      end

      def best_known_users_of_current_week
        User
          .select('users.id, given_name, family_name, SUM(correct_user_id=answer) / COUNT(*) AS ratio')
          .joins('INNER JOIN `who_am_is` ON `who_am_is`.`correct_user_id` = `users`.`id`')
          .where('who_am_is.created_at BETWEEN ? AND ?', @first_day_of_current_week, @last_day_of_current_week)
          .where('who_am_is.played = 1')
          .group(:correct_user_id)
          .order('ratio DESC')
          .limit(10)
          .delete_if { |user| user.ratio < 0.25 }
      end

      def highscore_weekly_number_one
        # Returns all users scores for each week as [week, user_id]=>points/value
        # sorted at week primary with highest value/points first.
        points_weeks = game_class
          .where(correct_condition)
          .group("yearweek(created_at, 1)")
          .group(:user_id)
          .order("yearweek_created_at_1 DESC")
          .order("count_all DESC")
          .count

        # We always meet the highest score first, since the hash is ordered by
        # score. We therefore ignore all weeks that already have a high score.
        highscore_weekly = Hash.new
        current_week = Date.today.year.to_s + Date.today.cweek.to_s

        points_weeks.each do |week_and_user, points|
          week, user = week_and_user

          next if week.to_s.eql? current_week

          unless highscore_weekly.has_key?(week)
            highscore_weekly[week] = [user, points]
          end
        end

        highscore_weekly
      end

      def user_stats_for(id)
        user_games = game_class.where(user_id: id)
        points     = user_games.where(correct_condition).count
        played     = user_games.where(played: 1).count
        ratio      = points.to_f / played

        {
          points_earned: points,
          played_games: played,
          percentage_won: ratio,
        }
      end

      private
      def game_class
        game.to_s.singularize.camelize.constantize
      end

      def game_string
        game.to_s
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
