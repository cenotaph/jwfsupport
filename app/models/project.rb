class Project < ApplicationRecord
  mount_uploader :icon, ImageUploader
  resourcify
  extend FriendlyId
  friendly_id :name, use: [:slugged]
end
