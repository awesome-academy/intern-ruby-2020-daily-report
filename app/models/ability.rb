class Ability
  include CanCan::Ability

  def initialize user
    return if user.blank?

    can :manage, Report, user_id: user.id
    can :manage, User, id: user.id
    return unless user.manager?

    can [:read, :update], Report
    can [:read, :create, :update], User
  end
end
