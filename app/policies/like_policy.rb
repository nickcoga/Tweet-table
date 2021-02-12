class LikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return raise Pundit::NoAuthorizedError if user.nil?

    user&.admin? || user&.member?
  end

  def destroy?
    return raise Pundit::NoAuthorizedError if user.nil?

    user&.admin? || user&.member?
  end
end
