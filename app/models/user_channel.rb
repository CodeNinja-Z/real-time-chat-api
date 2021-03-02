class UserChannel < ApplicationRecord

  # == Relationships ========================================================

  belongs_to :user
  belongs_to :channel

  # == Validations ==========================================================

  validates_presence_of :user_id
  validates_presence_of :channel_id
end
