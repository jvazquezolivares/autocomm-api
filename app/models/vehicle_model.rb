class VehicleModel < ApplicationRecord

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :vehicle_brand, presence: true

  belongs_to :vehicle_brand
  has_many :vehicles

  def self.find_or_create_vehicle_model(**params)
    model = VehicleModel.find_by_name(params["model"])
    return model unless model.nil?
    
    brand = VehicleBrand.find_or_create_by(name: params["brand"])
    VehicleModel.create!(name: params["model"], vehicle_brand: brand)
  end
end
