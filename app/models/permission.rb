class Permission < ApplicationRecord
  belongs_to :member
  belongs_to :role
  def is?( requested_role )
    self.role_id == requested_role.to_i
  end
end
