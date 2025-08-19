class RecipePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
  def index?
    true
  end
  def myrecipes?
    user.present?
  end
  def show?
    true
  end
  def new?
    user.present?
  end
  def create?
    user.present?
  end
  def destroy?
    record.user == user
  end
  def update?
    user.present?
  end

  def edit?
    user.present?
  end
end
