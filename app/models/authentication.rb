class Authentication < ApplicationRecord
  belongs_to :user
  validates_presence_of :provider
  after_create :map_to_project
  
  def self.find_for_oauth(auth)
     find_or_create_by(username: auth.username, provider: auth.provider)
  end
  
  def map_to_project
    unless USER_MAPPING[username].nil?
      USER_MAPPING[username].each do |project_id|
        user.projects << Project.find(project_id)
      end
      user.save
    end
  end
  
end
