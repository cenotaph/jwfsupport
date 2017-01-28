class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :registerable, 
         :recoverable, :rememberable, :trackable
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications, :reject_if => proc { |attr| attr['username'].blank? }
  extend FriendlyId
  friendly_id :username , :use => [ :slugged, :finders]
  has_and_belongs_to_many :projects
  mount_uploader :avatar, ImageUploader
  
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
  
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_hash).first
    end
  end

  def apply_omniauth(omniauth)
    # if omniauth['provider'] == 'twitter'
    #   logger.warn(omniauth.inspect)
    #   self.username = omniauth['info']['nickname']
    #   self.name = omniauth['info']['name']
    #   self.name.strip!
    #   identifier = self.username

    if omniauth['provider'] == 'facebook'
      self.email = omniauth['info']['email'] if email.blank? || email =~ /change@me/
      self.username = omniauth['info']['name']
      self.name = omniauth['info']['name'] 
      self.name.strip!
      identifier = self.username
      # self.location = omniauth['extra']['user_hash']['location']['name'] if location.blank?
    # elsif omniauth['provider'] == 'github'
    #   self.email = omniauth['info']['email'] if email.blank? || email =~ /change@me/
    #   self.username = omniauth['info']['nickname']
    #   self.name = omniauth['info']['name']
    #   self.name.strip!
    #   identifier = self.username
    # elsif omniauth['provider'] == 'google_oauth2'
    #   self.email = omniauth['info']['email']
    #   self.name = omniauth['info']['name']
    #   self.username = omniauth['info']['email'].gsub(/\@gmail\.com/, '')
    #   identifier = self.username
    end
    if email.blank?
      if omniauth['info']['email'].blank?
        self.email = "#{TEMP_EMAIL_PREFIX}-#{omniauth['uid']}-#{omniauth['provider']}.com"
      else
        self.email = omniauth['info']['email']
      end
    end
    
    # self.password = SecureRandom.hex(32) if password.blank?  # generate random password to satisfy validations
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :username => identifier)
  end
  
    
end
