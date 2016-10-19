class Authorization < ApplicationRecord
  belongs_to :user

  validates :provider, :uid, :user, presence: true
  validates :uid, uniqueness: true
end

