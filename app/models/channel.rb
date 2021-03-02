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

  def self.available_to_user(user)
    # returns all available channels to a user
    # channel can be public or private/joined or not-joined
    # all available channels = user joined channels + rest of public channels
    
    all_available_channels = []
    joined_channels = user.channels.as_json
    public_channels = self.where(is_public: true).as_json
    visible_channels = (public_channels | joined_channels).as_json

    visible_channels.each do |c|
      if (joined_channels.include?(c))
        all_available_channels << c.merge('joined' => true)
      else
        all_available_channels << c.merge('joined' => false)
      end
    end

    all_available_channels
  end
  
  # == Instance Methods =====================================================

  def messages_payload
    messages.order(created_at: :desc).includes(:user).map do |message|
      {
        message_id: message.id,
        username: message.user.username,
        channel_name: message.channel.name,
        content: message.content,
        created_at: message.created_at
      }
    end
  end
end
