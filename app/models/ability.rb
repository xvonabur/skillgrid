class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :read, :all
      can :make_pro, Product
      can :see_pro_ones, Product
      cannot [:create, :delete], Product
    elsif user.shop_owner?
      can :read, :all
      can :see_pro_ones, Product
    elsif user.guest?
      can :read, :all
      can :see_pro_ones, Product
    else
      can :read, :all
      cannot :make_pro, Product
    end
  end
end
