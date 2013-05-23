class RsvpsController < ApplicationController
  respond_to :json

  def index
    respond_with Rsvp.all
  end

  def show
    respond_with Rsvp.find(params[:id])
  end

  def create
    respond_with Rsvp.create(exercise_params)
  end

  def update
    respond_with Rsvp.update(params[:id], exercise_params)
  end

  def destroy
    respond_with Rsvp.destroy(params[:id])
  end

  private

  def exercise_params
    params.require(:rsvp).permit(:name, :attending, :message)
  end

end
