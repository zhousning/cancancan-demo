class Permission < ActiveRecord::Base
  has_many :role_permissionships
  has_many :roles, :through => :role_permissionships

  belongs_to :user
end
