class ChannelsChannel < ApplicationCable::Channel
  def subscribe
    stop_all_streams
    current_user.channels.find_each do |channel|
      stream_from "channel_#{channel.id}"
    end
  end

  def unsubscribe
    stop_all_streams
  end

  def receive(data)
    message = Message.new
    message.content = data["body"]
    message.user_id = current_user.id
    message.channel_id = data["channel_id"]
    message.save!

    ChannelsChannel.broadcast_to(
      "channel_#{message.channel_id}", 
      message.as_json(include: [user: { only: [:username]}])
    )
  end
end
