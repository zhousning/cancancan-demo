class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    #user.roles.each { |role| send(role.to_sym) }
    user.role.permissions.each do |permission|
      if permission.subject_class == "all"
        can permission.action.to_sym, permission.subject_class.to_sym
      else
        can permission.action.to_sym, permission.subject_class.constantize
      end
    end

   # can do |action, subject_class, subject|
   #   user.permissions.find_all_by_action(aliases_for_action(action)).any? do |permission|
   #     permission.subject_class == subject_class.to_s && (subject.nil? || permission.subject_id.nil? || permission.subject_id == subject.id)
   #   end
   # end

   # if user.roles.size == 0
   #   can :read, :all #for guest without roles
   # end

    #if user.has_role? :admin
    #  can :manage, :all
    #elsif user.has_role? :banned
    #  can :read, :all
    #end
  end

 # def manager
 #   can :manage, Product
 # end

 # def admin
 #   manager
 #   can :manage, Forum
 # end
end
