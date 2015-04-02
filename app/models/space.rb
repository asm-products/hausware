class Space < ActiveRecord::Base
  belongs_to :location
  has_many :slides, as: :slideshowable
end
