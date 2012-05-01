class WhoAmIController < ApplicationController
  def index
  end

  def game
  	@user1 = User.find(848)
  	@user2 = User.find(131)
  end

  def feedback
  end

  def highscore
  end
end
