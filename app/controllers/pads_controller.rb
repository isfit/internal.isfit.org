class PadsController < ApplicationController
  def index
    @pads = Pad.all
  end

  def create
    @pad = Pad.random
    if @pad.save
      redirect_to pad_path(@pad.hash), notice: "Pad was successfully created."
    else
      render redirect_to pads_path, notice: "Pad could not be created"
    end
  end

  def show
    @pad = Pad.where(hash: params[:hash])
  end

  def delete
    @pad = Pad.where(hash: params[:hash])
    if @pad.destroy
      redirect_to pads_path, notice: "Pad was successfully deleted."
    else
      redirect_to pads_path, warning: "Something went wrong. Pad was not deleted."
    end
  end
end
