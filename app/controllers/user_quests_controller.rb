class UserQuestsController < ApplicationController

  def finish_quest
    @quest = UserQuest.find(params[:id])
    if @quest.npc_id == current_user.id and @quest.deadline > DateTime.now
      @quest.completed_at = DateTime.now
      @quest.status = 2
      @quest.save
      redirect_to user_path(@quest.hero_id), notice: "Quest approved!"
    else
      redirect_to root_path, alert: "You cannot approve this deadline!"
    end
  end

  def stats
    @stats = UserQuest.where("status = 2").group("hero_id").order("count_all DESC").limit(20).count("*")
  end

end
