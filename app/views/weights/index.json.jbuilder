json.array!(@weights) do |weight|
  json.extract! weight, :id, :Weight, :Units, :Date, :user_id
  json.url weight_url(weight, format: :json)
end
