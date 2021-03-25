class GenericAutocomm

  MODEL_TYPES = [{ name: 'vehicle', model: Vehicle.new }]

  def select_configuration(model_type)
    byebug
    type = MODEL_TYPES.find{ |type| type[:name].eql?(model_type) }
    type[:model]
  end

  def search_by_criteria **params
    type = select_configuration(params["type"])
    type.search_by_criteria(params["criteria"])
  end
end