class CommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end
  def destroy?
    create? && (record.user == user || user.admin? || user.moderator?)
  end
end