class Ability 
  include CanCan::Ability 
  
  def initialize(user)
    if user.admin?
      can :manage, :all
    else 
      can :read, Course
      can [:create, :update], Cart
      can :read, Cart, :user_id => user.id
      can [:create, :update, :destroy], LineItem
      cannot :read, LineItem
    end 
  end 
end 
      