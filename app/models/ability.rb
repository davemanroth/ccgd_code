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

    #anonymous
    can :create, User

    # Submitter
    if user.has_role?(5) && user.is_active?
      can [:read, :update], User, id: user.id
      can :crud, Proposal, user_id: user.id
    end

    if user.has_role?(3)
      can :review, User
      can :review, Proposal
    end

    # Faculty and Advisors
    if user.has_role?(2) || user.has_role?(4)
      can :vote, Proposal
      can :crud, MemberVote, user_id: user.id
    end

    # Admin
    if user.has_role?(1)
      can :manage, :all
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
