class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    user.roles.each { |role| send(role.to_sym) }

   # if user.roles.size == 0
   #   can :read, :all #for guest without roles
   # end

    #if user.has_role? :admin
    #  can :manage, :all
    #elsif user.has_role? :banned
    #  can :read, :all
    #end
  end

  def manager
    can :manage, Product
  end

  def admin
    manager
    can :manage, Forum
  end
end
