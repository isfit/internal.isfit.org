class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.role?(:admin)
      can :manage, :all
    end
    if user.role?(:board)
      can :manage, Applicant
    end
    if user.role?(:recruiting)
      can :manage, Applicant
      can :manage, Host
    end
    if user.role?(:leader)
      can :manage, Applicant
      can :manage, Article
      can :manage, Motd
    end
    if user.role?(:wingman)
      can :manage, Applicant
    end
    if user.role?(:interviewer)
      can :manage, Applicant
    end
    if user.role?(:parliament)
      can :manage, Parliament
    end
    if user.role?(:editorial)
      can :manage, FrontendArticle
      can :manage, SppArticle
      can :manage, SppPage
      can :manage, StaticPage
      can :manage, IsfitPage
      can :manage, Motd
    end
    if user.role?(:spp_editor)
      can :manage, SppArticle
      can :manage, SppPage
    end
    if user.role?(:internal)
      can :manage, Account
      can :read, StaticPage
      can [:read,:create,:update,:attending,:notattending], Article
      can :manage, Kvitter
      #can :stats, Participant
      can [:read,:create], RoomBooking
      can :destroy, RoomBooking, user_id: user.id
      can :read, Room
      can :manage, WikiPage
      can :manage, ContactLogPerson
      can :manage, ContactLogUnit
      can :manage, ContactLog
      can :manage, WikiCategory
      can :manage, LayoutJob
      can :manage, WhoAmI
      can :manage, WhatAmI
    end
    if user.role?(:participant)
      can :manage, Participant
      can :manage, ParticipantQuote
    end
    if user.role?(:dialogue)
      can :manage, DialogueParticipant
      can :read, Participant
    end
    if user.role?(:sec)
      can :manage, CardChecker
      can :manage, Host
    end
    if user.role?(:campaign)
      can :manage, CampaignStory
    end
    if user.role?(:transport)
      can :manage, Drive
      can :manage, Driver
      can :manage, Shift
      can :manage, Car
      can :manage, TransportResponsible
      can [:index, :create_driver, :info, :driver_new, :driver_register], :drive_admin
      #can [:index, :create, :admin, :admin_create_car, :admin_destroy_car, :admin_edit_car, :admin_add_driver, :todo_all, :todo_you, :todo_user, :save_comment, :update_completed, :info, :driver_new, :driver_register ], :transport_system
      can [:index, :create, :destroy, :shifts_you], :driver_shift
    end
    transport_responsible = TransportResponsible.find_by(user: user)
    if transport_responsible
      can :create, Drive
      can :read, Drive, :group_id => transport_responsible.group_id
      can [:edit,:destroy], Drive do |drive|
        drive.group_id == transport_responsible.group_id && drive.status == 0
      end
    end
    driver = Driver.find_by(user: user)
    if driver
      can :index, Drive
      can :read, Drive, :driver_id => driver.id
      can :read, Shift, :driver_id => driver.id
    end

    if user.role?(:plenarysessions)
      can :manage, IndabaSpeaker
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
