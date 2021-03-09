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
end


=begin

What is as_json?

Now the creation of the json is separate from the rendering of the json.
as_json is used to create the structure of the JSON as a Hash, 
and the rendering of that hash into a JSON string is left up to ActiveSupport::json.encode.
You should never use to_json to create a representation, only to consume the representation.

=end


=begin

# Query Speed Comparison
# The 3 queries below do the same thing but speeds are totally different
User.joins(:channels).where(channels: {name: 'Furniture'}) - fastest
Channel.where(name: 'Furniture').first.users - 2nd
User.includes(:channels).where(channels: {name: 'Furniture'}) - slowest

# Conclusion: Eager Load isn't the best choice for all times
# joins is the best choice for getting a collection with no further query

=end



=begin

# How to chain 2 where clauses
(A && B) || C:
    Post.where(a).where(b).or(Post.where(c))

(A || B) && C:
    Post.where(a).or(Post.where(b)).where(c)

User.joins(:channels).where("users.username = ?", 'jacki')
  .or(User.joins(:channels).where("channels.name = ?", 'jacki'))

=end