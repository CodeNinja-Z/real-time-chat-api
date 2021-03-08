class Api::V1::UserChannelsController < ApplicationController
  # endpoint to call when a user joins a channel
  def create
    user_channel = UserChannel.new(user_channel_params)
    user_channel.joined_at = DateTime.now
    user_channel.save!
    json_response(user_channel)
  end
  
  private

  def user_channel_params
    params.permit(:user_id, :channel_id)
  end
end
