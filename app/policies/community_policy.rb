class CommunityPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def new?
    create?
  end

  def create?
    user.admin
  end

  def mycommunities?
    true
  end

  def show?
    true
  end

  def edit?
    user.admin
  end

  def update?
    edit?
  end

  def message?
    true
  end
end
