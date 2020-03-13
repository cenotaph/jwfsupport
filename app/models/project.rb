class Project < ApplicationRecord
  mount_uploader :icon, ImageUploader
  resourcify
  extend FriendlyId
  friendly_id :name, use: [:slugged]
  has_and_belongs_to_many :users
  has_many :tickets, dependent: :destroy
end
