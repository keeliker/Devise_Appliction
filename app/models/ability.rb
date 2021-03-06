class Ability
  include CanCan::Ability

  def initialize(user)
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
    if user.blank?
      # not logged in
      cannot :manage, :all
    #basic_read_only
    #elsif user.authorize(:admin)
    elsif user.authorize == 'admin'
      # admin

      can :manage, :all

    #elsif user.authorize(:common)
    elsif user.authorize == 'common'
      
      can :update, Idea do |idea|
        (idea.user_id == user.id)
      end
  
      cannot :destroy, :all
      
      can :new, @avatar

      if user.ideas_count >= 1
        cannot :new, @idea
      end

    #elsif user.authorize(:rookie)
    elsif user.authorize == 'rookie'      
      cannot :manage, :all
        #basic_read_only
    end


    #protected

    #def basic_read_only
    #  can :read,    Idea
    #  can :list,    Idea
    #  can :search,  Idea
    #end

    def load_and_authorize_resource
      load_resource
      authorize_resource
    end

  end
end
