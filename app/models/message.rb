class Message < ApplicationRecord

  # == Relationships ========================================================

  belongs_to :user
  belongs_to :channel

  # == Validations ==========================================================

  validates_presence_of :user_id
  validates_presence_of :channel_id
  validates_presence_of :content

  # == Instance Methods =====================================================

  def as_json(**options)
    super({only: [:id, :created_at]}.merge(options))
  end
end
