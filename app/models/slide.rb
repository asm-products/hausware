class Slide < ActiveRecord::Base
  belongs_to :slideshowable, polymorphic: true
end
