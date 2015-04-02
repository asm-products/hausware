class Slide < ActiveRecord::Base
  belongs_to :slideshowable, polymorphic: true
  
  has_attached_file :picture, storage: :s3, s3_credentials: { bucket: "#{ENV["PAPERCLIP_S3_BUCKET_PREFIX"]}-#{Rails.env}" }
  
  validates_attachment :picture, presence: true, content_type: { content_type: /\Aimage\/.*\Z/ }, size: { in: 0..10.megabytes }
  validates :slideshowable, presence: true
end
