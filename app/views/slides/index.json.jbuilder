json.array!(@slides) do |slide|
  json.extract! slide, :id, :slideshowable_id, :picture, :order, :caption
  json.url slide_url(slide, format: :json)
end
