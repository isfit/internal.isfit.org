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
          .where("#{game.to_s}.played = 1 AND answer = 1")
          .group("users.id")
          .order("score DESC")
          .limit(10)
      end
    end
  end
end
