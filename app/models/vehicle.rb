class Vehicle < ApplicationRecord
  validates :vehicle_model, presence: true
  validates :year, presence: true
  validates :price, presence: true
  validates :mileage, presence: true

  belongs_to :vehicle_model

  PARAMS_PERMITED = %W(vehicle_brand vehicle_model year price mileage)
  VEHICLE_FIELDS = %W(year price mileage)
  OPERATIONS_BY_FIELD = { year: ">", mileage: "<", price: "<" }

  def self.create_vehicle(**params)
    PARAMS_PERMITED.each do |param| 
      return nil unless params.key?(param) 
    end
    
    model = VehicleModel.find_or_create_vehicle_model(**params)

    vehicle = Vehicle.new(
      year: params["year"],
      price: params["price"],
      mileage: params["mileage"],
      vehicle_model: model
    ).save!
    vehicle
  end

  def self.search_by_criteria(**params)
    type = params["type"]
    criteria = params["criteria"]
    return false unless PARAMS_PERMITED.include?(type)
      
    if VEHICLE_FIELDS.include?(type)
      where_operation = "#{type} #{OPERATIONS_BY_FIELD[type.to_sym]} ?"
      results = Vehicle.where(where_operation, "#{criteria}")
    else
      results = Vehicle
         .includes(vehicle_model: [:vehicle_brand])
         .where("#{type}": { name: "#{criteria}" })
    end

    results.map do |result|
      {
        id: result.id,
        model_name: result.vehicle_model&.name,
        brand_name: result.vehicle_brand&.name,
        year: result.year,
        mileage: result.mileage,
        price: result.price
      }
    end

  end

  def vehicle_brand
    self.vehicle_model&.vehicle_brand
  end
end
