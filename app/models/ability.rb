class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role?(:admin)
      can :manage, :all
    end
    if user.role?(:recruiting)
      can :manage, Applicant
    end
    if user.role?(:leader)
      can :manage, Applicant
      can :manage, Article
   end
    if user.role?(:wingman)
      can :manage, Applicant
    end
    if user.role?(:interviewer)
      can :manage, Applicant
    end
    if user.role?(:editorial)
      can :manage, FrontendArticle
      can :manage, SppArticle
      can :manage, SppPage
      can :manage, StaticPage
      can :manage, IsfitPage
    end
    if user.role?(:spp_editor)
      can :manage, SppArticle
      can :manage, SppPage
    end
    if user.role?(:internal)
      can :manage, Account
      can :read, StaticPage
      can [:read,:create,:update], Article
      can :manage, Kvitter
      can :stats, Participant
      can [:read,:create], RoomBooking
      can :destroy, RoomBooking, user_id: user.id
      can :read, Room
      can :manage, WikiPage
      can :manage, ContactLogPerson
      can :manage, ContactLogUnit
      can :manage, ContactLog
      can :manage, WikiCategory
      can :manage, LayoutJob
    end
    if user.role?(:participant)
      # can :manage, Participant
      can :manage, ParticipantQuote
    end
    if user.role?(:dialogue)
      can :manage, DialogueParticipant
      can :read, Participant
    end
    if user.role?(:sec)
      can :manage, CardChecker
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
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
