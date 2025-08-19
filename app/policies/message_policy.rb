class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      ##This fixes the issue,
      # if scope.all.none? {|element| element.user_id == user.id}
      #  raise Pundit::NotAuthorizedError, 'Not allowed to view this action'
      # else
        scope.all
    #   end
    end
  end

  def show?
    user.communities.include?(record.community)
  end

  def new?

  end

  def create?
    true
  end

  def destroy?
    user.admin || record.user == user
  end
end
