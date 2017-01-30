class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :user
  validates_presence_of :ticket_id, :user_id
  
  mount_uploader :attachment, AttachmentUploader
  mount_uploader :image, ImageUploader
  
  before_save :update_image_attributes
  attr_accessor :send_email
  
  private
  
  def update_image_attributes
    if image.present? && image_changed?
      if image.file.exists?
        self.image_content_type = image.file.content_type
        self.image_size = image.file.size
        self.image_width, self.image_height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
      end
    end
  end
  
end
