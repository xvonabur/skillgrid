class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :read, :all
      can :make_pro, Product
      can :see_pro_ones, Product
      can :read_shop_name, Product
      cannot [:create, :delete], Product
    elsif user.shop_owner?
      can :read, :all
      can :see_pro_ones, Product
      can :read_shop_name, Product
      can [:create, :delete, :update], Product
    elsif user.guest?
      can :read, :all
      can :see_pro_ones, Product
      cannot [:create, :delete], Product
      cannot :read_shop_name, Product
    else
      can :read, :all
      cannot :make_pro, Product
    end
  end
end
