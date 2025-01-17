class AuthenticationPolicy < ApplicationPolicy
  def destroy?
    @user && @user.can_remove_auth?(@record)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
