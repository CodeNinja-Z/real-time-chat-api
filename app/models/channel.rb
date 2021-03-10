class Channel < ApplicationRecord

  # == Relationships ========================================================

  has_many :messages
  has_many :user_channels
  has_many :users, through: :user_channels
  
  # == Validations ==========================================================

  validates :name, 
    presence: true,
    length: { minimum: 4, maximum: 40 },
    uniqueness: true

  # == Class Methods ========================================================

  def self.to_payload(data, page, per_page, **options)
    data.paginate(page: page, per_page: per_page)
      .as_json
      .map do |channel|
        channel.merge(options)
    end
  end
  
  # == Instance Methods =====================================================

  def to_payload(page, per_page)
    messages.includes(:user)
      .paginate(page: page, per_page: per_page)
      .map do |message|
        {
          message_id: message.id,
          username: message.user.username,
          channel_name: message.channel.name,
          content: message.content,
          created_at: message.created_at
        }.as_json
    end
  end

  def as_json(**options)
    super({only: [:id, :name, :is_public]}.merge(options))
  end
end
