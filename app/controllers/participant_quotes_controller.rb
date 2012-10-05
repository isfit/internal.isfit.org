class ParticipantQuotesController < ApplicationController
   load_and_authorize_resource

  # GET /participant_quotes
  # GET /participant_quotes.json
  def index
    @participant_quotes = ParticipantQuote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participant_quotes }
    end
  end

  # GET /participant_quotes/1
  # GET /participant_quotes/1.json
  def show
    @participant_quote = ParticipantQuote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participant_quote }
    end
  end

  # GET /participant_quotes/new
  # GET /participant_quotes/new.json
  def new
    @participant_quote = ParticipantQuote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participant_quote }
    end
  end

  # GET /participant_quotes/1/edit
  def edit
    @participant_quote = ParticipantQuote.find(params[:id])
  end

  # POST /participant_quotes
  # POST /participant_quotes.json
  def create
    @participant_quote = ParticipantQuote.new(params[:participant_quote])
    @participant_quote.user_id = current_user.id

    respond_to do |format|
      if @participant_quote.save
        format.html { redirect_to @participant_quote, notice: 'Participant quote was successfully created.' }
        format.json { render json: @participant_quote, status: :created, location: @participant_quote }
      else
        format.html { render action: "new" }
        format.json { render json: @participant_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /participant_quotes/1
  # PUT /participant_quotes/1.json
  def update
    @participant_quote = ParticipantQuote.find(params[:id])

    respond_to do |format|
      if @participant_quote.update_attributes(params[:participant_quote])
        format.html { redirect_to @participant_quote, notice: 'Participant quote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @participant_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participant_quotes/1
  # DELETE /participant_quotes/1.json
  def destroy
    @participant_quote = ParticipantQuote.find(params[:id])
    @participant_quote.destroy

    respond_to do |format|
      format.html { redirect_to participant_quotes_url }
      format.json { head :no_content }
    end
  end
end
