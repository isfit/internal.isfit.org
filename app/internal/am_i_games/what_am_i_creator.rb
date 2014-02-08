module Internal
  module AmIGames
    class WhatAmICreator
      attr_reader :game, :users

      def initialize current_user
        @current_user = current_user
        @users = []

        game = WhatAmI
          .where(user_id: @current_user.id, played: false)
          .order("created_at DESC").limit(1).first

        # If user has a previous unplayed game, give him that one again.
        if game && !(User.find(game.correct_user_id).positions.empty?)
          reload_old game
        else
          new_game
        end
      end

      def correct_user
        users.select {|user| user.id == @game.correct_user_id }.first
      end

      private
      def reload_old game
        @game = game
        @users[0] = User.find(@game.user_1_id)
        @users[1] = User.find(@game.user_2_id)
        @users[2] = User.find(@game.user_3_id)
        @users[3] = User.find(@game.user_4_id)
      end

      def new_game
        @users = User.random(2015,4)
        correct_id = users[Random.rand(users.length)].id

        @game = WhatAmI.create!(
          user_id: @current_user.id,
          played: false,
          correct_user_id: correct_id,
          user_1_id: users[0].id,
          user_2_id: users[1].id,
          user_3_id: users[2].id,
          user_4_id: users[3].id
        )
      end
    end
  end
end
