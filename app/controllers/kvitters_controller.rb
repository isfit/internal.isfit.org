class KvittersController < ApplicationController
  load_and_authorize_resource
  protect_from_forgery :except => :create

  def create
    logger.debug "Kom hit"
    @kvitter = Kvitter.new
    @kvitter.message = params[:message]
    @kvitter.user_id = current_user.id
    if @kvitter.save
      render :json => @kvitter.to_json(methods: :username)
    else
      render :text => "failed"
    end
  end

  def last
    @kvitters = Kvitter.order("created_at desc").limit(10)
    respond_to do |format|
      format.json do
        render json: @kvitters.to_json(methods:
                                        [:username,
                                         :awesome_count,
                                         :user_full_name,
                                        ])
      end
    end
  end

  def index
    @kvitters = Kvitter.paginate(page: params[:page]).order("created_at desc")

    respond_to do |format|
      format.html
    end
  end


  def awesome
    @user_liked = current_user.id
    @liked_kvitter = params[:id]

    self_awesoming Kvitter.find(@liked_kvitter).user_id

    if Awesome.where("kvitter_id = #{@liked_kvitter}").where("user_id = #{@user_liked}").first == nil
      @awesome = Awesome.new
      @awesome.user_id = @current_user.id
      @awesome.kvitter_id = @liked_kvitter
      if @awesome.save
        @count = Awesome.where("kvitter_id = #{@liked_kvitter}").count
        render :json => @count.to_json
        return
      end
    end
    render :json => Awesome.where("kvitter_id = #{@liked_kvitter}").count.to_json
  end

  def within_a_div
    index
  end

  private
  def self_awesoming(user_id_on_kvitter)
    if user_id_on_kvitter == current_user.id
      k = Kvitter.new
      k.user_id = 1
      k.message = "Kleint? @#{User.find(user_id_on_kvitter).username} ga nettopp en awesome til sin egen kvitter. #PlaceholdersenSerAlt"
      k.save
    end
  end
end
