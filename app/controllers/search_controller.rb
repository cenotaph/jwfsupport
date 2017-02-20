class SearchController < ApplicationController
    
  def create
    @tickets = []
    @tickets += Ticket.advanced_search(params[:searchterm])
    @tickets += Comment.advanced_search(params[:searchterm]).map(&:ticket)
    @tickets = @tickets.flatten.compact.uniq.sort_by(&:id).reverse

  end
end
