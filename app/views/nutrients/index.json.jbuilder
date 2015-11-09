json.array!(@nutrients) do |nutrient|
  json.extract! nutrient, :id, :ref_id, :name, :group, :unit, :value, :food_id
  json.url nutrient_url(nutrient, format: :json)
end
