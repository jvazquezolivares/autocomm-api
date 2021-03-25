class Api::V1::SearchController < ApplicationController
  
  def search_by_criteria
    results = Vehicle.search_by_criteria(**search_parameters)
    unless results
      render json: { message: 'Something went wrong!' }, status: :bad_request
    else
      render json: { results: results }, status: :ok
    end
  end

  private
  def search_parameters
    params.permit(:criteria, :type)
  end

  def model
    @model || GenericAutocomm.new
  end
end