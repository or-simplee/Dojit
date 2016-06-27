class CommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end
  def destroy?
    create? && can_moderate?
  end
end