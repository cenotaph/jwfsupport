class Comment < ApplicationRecord
  belongs_to :ticket, touch: true
  belongs_to :user
  validates_presence_of :ticket_id, :user_id
  
  mount_uploader :attachment, AttachmentUploader
  mount_uploader :screenshot, ImageUploader
  
  before_save :update_image_attributes
  attr_accessor :send_email
  
  private
  
  def update_image_attributes
    if screenshot.present? && screenshot_changed?
      if screenshot.file.exists?
        self.screenshot_content_type = screenshot.file.content_type
        self.screenshot_size = screenshot.file.size
        self.screenshot_width, self.screenshot_height = `identify -format "%wx%h" #{screenshot.file.path}`.split(/x/)
      end
    end
  end
  
end
