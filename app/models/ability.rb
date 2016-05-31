class Ability
  include CanCan::Ability

  # Role key
  #
  # 1: Administrator
  # 2: Faculty
  # 3: Staff
  # 4: Advisor
  # 5: Submitter

  def initialize(user)

    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud
    # Admin
    if user.has_role?(1)
      can :manage, :all
    end

=begin
    # faculty
    if user.has_role?(2)
    end

    # Staff
    if user.has_role?(3)
    end

    # Advisor
    if user.has_role?(4)
    end
=end

    # Submitter
    if user.has_role?(5)
      can [:read, :update], User do |us|
        us == user
      end

      can :crud, Proposal
    end

    #anonymous
    can :create, User

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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
