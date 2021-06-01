class FriendRequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.present?
  end

  def accept?
    user.present?
  end

  def decline?
    user.present?
  end

end
