class Ability
  include CanCan::Ability

  def initialize(user)

    if user # logged_in
      can :manage, :all
    else
      can :manage, :root
    end

  end
end
