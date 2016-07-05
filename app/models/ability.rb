 class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    can :read, :all
    can :create, Comment
    can :manage, Comment do |comment|
      comment.try(:commenter).eql?(user.email)
    end

    if user.role? :admin
      can :manage, :all
    end
    if user.role? :author
      can [:update, :destroy, :create], [Article, Comment]
    end

  end
end
