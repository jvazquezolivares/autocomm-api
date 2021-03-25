class Api::V1::VehiclesController < ApplicationController
  def create
    begin
      debugger
      vehicle = Vehicle.create_vehicle(**vehicle_params)
      if vehicle
        render json: { message: 'vehicle created', vehicle: vehicle }, status: :ok
      else
        render json: { message: 'something went wrong!', vehicle: vehicle }, status: :bad_request
      end
    rescue StandardError => e
      render json: { message: 'something went wrong!' }, status: :unprocessable_entity
    end
  end

  private
  def vehicle_params
    params.require(:vehicle).permit(:brand, :model, :year, :price, :mileage)
  end
end