class PositionsController < ApplicationController
  def index
    positions = PositionResource.all(params)
    respond_with positions
  end
end
