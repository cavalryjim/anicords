class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Household do |household|
      household.new_record? or
      household.users.include?(user)
    end
    
    can :manage, Organization do |organization|
      organization.new_record? or
      organization.users.include?(user)
    end
    
    can :manage, Animal do |animal|
      animal.new_record? or
      animal.owner.users.include?(user)
    end
    
    can :view, ServiceProvider
    
    can :manage, ServiceProvider do |provider|
      provider.new_record? or
      provider.users.include?(user)
    end
    
    can :manage, User do |u|
      u.new_record? or
      u == user
    end
    
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
