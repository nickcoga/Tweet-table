class TweetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user&.admin? || user&.member?
  end

  def update?
    user&.admin? || user&.member?
  end

  def destroy?
    user&.admin? || user&.member?
  end
end
