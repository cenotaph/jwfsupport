class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 
    if user.has_role? :admin
      can :manage, :all
    else
      can :manage, Ticket do |ticket|
        ticket.project.users.include?(user)
      end

      cannot :manage, Project
      can :manage, User, id: user.id
    end
  end
  
end
