# JDavis: need to add admin_users to household, organization, service_provider, breeder, veterinarian etc.

# JDavis: here is a list of all the roles:
#-----------Household roles-----------------
#   :member - has full access to the household info and animal info
#   :limited_member - read access for household info and update access for animals
#   :sitter - read only for animal info

#-----------Organization roles-----------------
#   :admin - has full access to organizational info and animal info
#   :admin_dogs - has full access to the organization's dogs
#   :admin_cats - has full access to the organization's cats
#   :org_member - has update only permission on animals
#   :org_foster - has update only permission on animals fostered with them
#   :org_vet - has update only permission on all organizational animals

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Animal do |animal|
      animal.new_record? or
      #animal.owner.users.include?(user) or
      can? :manage, animal.owner or
      ((user.has_role? :admin_dogs, animal.owner) && (animal.species == 'dog')) or
      ((user.has_role? :admin_cats, animal.owner) && (animal.species == 'cat'))
    end
    
    can :update, Animal do |animal|
      (user.has_role? :member_limited, animal.owner) or
      (user.has_role? :org_member, animal.owner) or
      (user.has_role? :org_vet, animal.owner) or 
      # JDavis: this is for fosters.
      if animal.org_profile.present? && animal.org_profile.organization_location.present?
        can? :manage, animal.org_profile.organization_location.location
      end
    end
    
    can [:read, :change_owner], Animal do |animal|
      user == animal.animal_transfer.transferee if animal.pending_transfer?
    end
    # JDavis: might want to combine these two (above & below) rules.
    can :read, Animal do |animal|
      animal.owner.users.include?(user)
      #animal.organization.users.include?(user) if animal.organization.present?  
    end
    
    can :manage, Adoption do |adoption|
      adoption.new_record? or
      #adoption.organization.admin_users.include?(user)
      can? :manage, adoption.animal or
      can? :manage, adoption.organization
    end
    
    can :manage, AnimalAssociation do |association|
      association.new_record? or
      association.animal.owner.users.include?(user)
    end
    
    can :manage, AnimalMedication do |medication|
      medication.new_record? or
      #medication.animal.owner.users.include?(user)
      can? :update, medication.animal
    end
    
    can :manage, AnimalVaccination do |vaccination|
      vaccination.new_record? or
      #vaccination.animal.owner.users.include?(user)
      can? :update, vaccination.animal
    end
    
    can :manage, Breeder do |breeder|
      breeder.new_record? or
      #breeder.users.include?(user)
      user.has_role? :admin, breeder
    end
    
    can :manage, Document do |document|
      document.new_record? or
      #document.animal.owner.users.include?(user)
      can? :update, document.animal
    end
    
    can :manage, Household do |household|
      household.new_record? or
      #household.users.include?(user) or 
      (user.has_role? :member, household)
    end
    
    can :read, Household do |household|
      (user.has_role? :limited_member )
    end
    
    can :manage, Location do |location|
      location.new_record? or
      #location.organizations.first.users.include?(user)
      can? :manage, location.organizations.first
    end
    
    can :manage, Notification do |notification|
      notification.new_record? or
      notification.recipient == user or 
      can? :manage, notification.animal or
      can? :manage, notification.recipient
      #(notification.animal.owner.users.include?(user) if notification.animal.present?) #or
      #(notification.recipient.users.include?(user if notification.recipient.users.present?))
    end
    
    can :manage, Organization do |organization|
      organization.new_record? or
      #organization.admin_users.include?(user) or 
      user.has_role? :admin, organization
    end
    
    can :read, Organization do |organization|
      organization.users.include?(user)
    end
    
    can :read, OrganizationLocation do |location|
      location.organization.users.include?(user)
    end
    
    can :manage, OrganizationLocation do |location|
      location.new_record? or
      can? :update, location.organization
      #location.organization.admin_users.include?(user)
    end
    
    can :manage, OrgProfile do |profile|
      profile.new_record? or
      #profile.animal.owner.users.include?(user)
      can? :manage, profile.animal or
      can? :manage, profile.animal.owner
    end
    
    can :read, Picture
    
    can :manage, Picture do |picture|
      picture.new_record? or
      can? :update, picture.animal
      #picture.animal.owner.users.include?(user)
    end
    
    can :read, ServiceProvider
    
    can :manage, ServiceProvider do |provider|
      provider.new_record? or
      (user.has_role? :admin, provider)
      #provider.users.include?(user)
    end
    
    can :manage, SitterRequest do |request|
      request.new_record? or
      can? :manage, request.household
      #request.household.users.include?(user)
    end
    
    can :manage, User do |u|
      u.new_record? or
      u == user
    end
    
    can :manage, UserAssociation do |association|
      association.new_record? or
      #association.user == user or
      can? :manage, association.user
      can? :manage, association.group
      #user.has_role? :admin, association.group or
      #association.group.admin_users.include?(user) or 
      #if association.group.class.name == "Household"
      #  user.has_role? :member, association.group
      #end
      #user.has_any_role? [{ :name => :member, :resource => association.group }, { :name => :admin, :resource => association.group }]
    end
    
    can :read, Veterinarian
    
    can :manage, Veterinarian do |veterinarian|
      veterinarian.new_record? or
      (user.has_role? :admin, veterinarian)
      #veterinarian.users.include?(user)
    end
    
    can :manage, Weight do |weight|
      weight.new_record? or
      can? :update, weight.animal
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
