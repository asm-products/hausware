class OrderedGood < ActiveRecord::Base
  belongs_to :order
  belongs_to :good
end
