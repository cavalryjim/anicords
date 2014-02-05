# JDavis: need to add admin_users to household, organization, service_provider, breeder, veterinarian etc.
class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Animal do |animal|
      animal.new_record? or
      animal.owner.users.include?(user)
    end
    
    can [:read, :change_owner], Animal do |animal|
      user == animal.animal_transfer.transferee if animal.pending_transfer?
    end
    
    can :manage, AnimalAssociation do |association|
      association.new_record? or
      association.animal.owner.users.include?(user)
    end
    
    can :manage, AnimalVaccination do |vaccination|
      vaccination.new_record? or
      vaccination.animal.owner.users.include?(user)
    end
    
    can :manage, Breeder do |breeder|
      breeder.new_record? or
      breeder.users.include?(user)
    end
    
    can :manage, Document do |document|
      document.new_record? or
      document.animal.owner.users.include?(user)
    end
    
    can :manage, Household do |household|
      household.new_record? or
      household.users.include?(user)
    end
    
    can :manage, Notification do |notification|
      notification.new_record? or
      notification.recipient == user
    end
    
    can :manage, Organization do |organization|
      organization.new_record? or
      organization.users.include?(user)
    end
    
    can :manage, OrgProfile do |profile|
      profile.new_record? or
      profile.animal.owner.users.include?(user)
    end
    
    can :read, Picture
    
    can :manage, Picture do |picture|
      picture.new_record? or
      picture.animal.owner.users.include?(user)
    end
    
    can :read, ServiceProvider
    
    can :manage, ServiceProvider do |provider|
      provider.new_record? or
      provider.users.include?(user)
    end
    
    can :manage, User do |u|
      u.new_record? or
      u == user
    end
    
    can :manage, UserAssociation do |association|
      association.new_record? or
      association.user == user or
      association.group.users.include?(user)
    end
    
    can :read, Veterinarian
    
    can :manage, Veterinarian do |veterinarian|
      veterinarian.new_record? or
      veterinarian.users.include?(user)
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
