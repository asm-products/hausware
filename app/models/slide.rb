class Slide < ActiveRecord::Base
  belongs_to :slideshowable, polymorphic: true
  
  has_attached_file :picture, storage: :s3, s3_credentials: { bucket: "#{ENV["PAPERCLIP_S3_BUCKET_PREFIX"]}-#{Rails.env}" }
  
  validates_attachment :picture, presence: true, content_type: { content_type: /\Aimage\/.*\Z/ }, size: { in: 0..10.megabytes }
  validates :slideshowable, presence: true
  
  attr_accessor :set_as_cover
  
  after_save :set_cover_url_too
  
  def set_cover_url_too
    return true unless self.set_as_cover # bypass if not
    self.slideshowable.update_attribute(:picurl, self.picture.url)
    true # don't worry if it didn't work
  end
end
