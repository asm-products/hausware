class Space < ActiveRecord::Base
  belongs_to :location
  has_many :slides, as: :slideshowable, dependent: :destroy
  has_many :reservations, dependent: :destroy
  
  before_validation :autofill_permalink_if_blank
  
  validates :permalink, presence: true, uniqueness: { case_sensitive: false, scope: :location_id }, format: { with: /\A[a-zA-Z0-9\-_]+\Z/ }
  validates :location, presence: true
  validates :standard_hourly_price_in_cents, presence: true
  
  def autofill_permalink_if_blank
    return true unless self.permalink.blank? # Bypass if permalink is already set
    self.permalink = AutoPermalink::cleaned_deduped_permalink(self.class, self.name)
  end

  def to_param
    self.permalink
  end
end
