 class Ability
  include CanCan::Ability

  def initialize(user)
    puts "\n\n\n\n user =  #{user.role.id}\n\n\n\n"
    user ||= User.new # guest user
    can :read, :all
    can [:update, :destroy, :create], [Comment]

    if user.role? :admin
      can :manage, :all
    end
    if user.role? :author
      can [:update, :destroy, :create], [Article, Comment]
    end

  end
end
