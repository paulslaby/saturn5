class Ability
  include CanCan::Ability

  def initialize(user)

    if user # logged_in
      can :manage, Invoice, user_id: user.id
    end
    can :manage, :root

  end
end
