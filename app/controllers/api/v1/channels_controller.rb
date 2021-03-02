class Api::V1::ChannelsController < ApplicationController
  before_action :set_channel, only: [:show]

  def index
    available_channels = Channel.available_to_user(current_user)
    json_response(available_channels)
  end

  def show
    channel_with_messages = @channel.messages_payload
    json_response(channel_with_messages)
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end
end
