class Reservation < ActiveRecord::Base
  belongs_to :space
  belongs_to :user
  
  validates :space, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
end
