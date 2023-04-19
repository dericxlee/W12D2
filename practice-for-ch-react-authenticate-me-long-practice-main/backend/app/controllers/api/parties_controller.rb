class Api::PartiesController < ApplicationController
  def index
    @parties = Party.includes(:guests).all
    render :index
  end

  def show
    @party = Party.includes(guests: [:gifts]).find(params[:id])

    # render :show
    render :normalized_show
  end
end