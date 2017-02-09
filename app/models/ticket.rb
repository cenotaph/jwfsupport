class Ticket < ApplicationRecord
  belongs_to :tickettype
  belongs_to :project
  belongs_to :user
  belongs_to :assigned, class_name: 'User', foreign_key: :assigned_id
  has_many :screenshots
  has_many :comments
  validates_presence_of :user_id, :tickettype_id, :project_id, :name, :description, :assigned_id
  attr_accessor :send_email, :system_call
  accepts_nested_attributes_for :screenshots, :reject_if => proc {|attributes| attributes['image'].blank? && attributes['image_cache'].blank?}, :allow_destroy => true
  accepts_nested_attributes_for :comments, reject_if: proc {|atr| atr['description'].blank? }
  scope :closed,  ->() { where(status: 2) }
  scope :opened, ->() { where("status is null or status <> 2")}
  # scope :opened, -> () { where(["resolution <> 2"]) }
  def urgency_class
    case urgency 
    when 0
      return "secondary"
    when 1
      return "primary"
    when 2
      return "warning"
    when 3
      return "alert"
    end    
  end
  
  def urgency_line
    case urgency 
    when 0
      return "not a big deal, but would be nice to get this done"
    when 1
      return "would really love this to happen soon"
    when 2
      return "this is really, really important"
    when 3
      return "HOLY SHIT DROP EVERYTHING IN YOUR LIFE AND FIX THIS NOW!!!!"
    end
  end
  
  def status_class
    case status
    when 0
      "primary"
    when 1
      "warning"
    when 2
      "success"
    when 3
      'warning'
    when 4
      'alert'
    when nil
      'primary'
    end
  end
  
  def status_line
    case status
    when 0
      "new"
    when 1
      "accepted"
    when 2
      "closed"
    when 3
      'reopened'
    when 4
      'waiting for feedback'
    when nil
      'new'
    end
  end
    
  def resolution_class
    case resolution
    when nil
      return 'warning'
    when 0
      return 'warning'
    when 1
      return 'success'
    when 2
      return 'secondary'
    when 3
      return 'secondary'
    when 4
      return 'secondary'
    end    
  end
  
  def resolution_line
    case resolution
    when nil
      return 'open'
    when 0
      return 'open'
    when 1
      return 'resolved'
    when 2
      return 'invalid'
    when 3
      return 'not applicable'
    when 4
      return 'duplicate'
    end
  end 
end
