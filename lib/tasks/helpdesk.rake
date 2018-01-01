
namespace :helpdesk do
  desc 'email all open ticket holders'
  task open_tickets: :environment do
    User.all.each do |user|
      next if user.tickets.opened.empty?
      puts "Sending email to " + user.email + " with " + user.tickets.opened.size.to_s + " open tickets"
      TicketMailer.old_open_tickets(user).deliver_later
    end
  end

end
