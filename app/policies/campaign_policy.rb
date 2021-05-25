class CampaignPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def edit?
    return record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
