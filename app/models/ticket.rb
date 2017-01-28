class Ticket < ApplicationRecord
  belongs_to :tickettype
  belongs_to :project
  belongs_to :user
  has_many :screenshots
  
  validates_presence_of :user_id, :tickettype_id, :project_id, :name, :description
  
  accepts_nested_attributes_for :screenshots, :reject_if => proc {|attributes| attributes['image'].blank? && attributes['image_cache'].blank?}, :allow_destroy => true
  
  
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
    when nil
      'new'
    end
  end
    
  def resolution_line
    case resolution
    when nil
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
