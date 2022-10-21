class Profile < ApplicationRecord
  USERNAME_REGEXP = /\A[a-z\d][a-z\d-]*[a-z\d]\z/i

  validates :superuser, presence: false
  validates :username, presence: true, uniqueness: true
  validates_format_of :username, with: USERNAME_REGEXP
end
