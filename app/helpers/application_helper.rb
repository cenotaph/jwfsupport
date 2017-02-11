module ApplicationHelper
  
  def find_tickets(description)
    return description.gsub(/\s\#(\d+)/, ' <a href="/tickets/\1">#\1</a>')
  end
end
