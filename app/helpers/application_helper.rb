module ApplicationHelper
  
  def find_tickets(description)
    return description.gsub(/\s\#(\d+)/, ' <a href="/tickets/\1">#\1</a>')
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
    
end
