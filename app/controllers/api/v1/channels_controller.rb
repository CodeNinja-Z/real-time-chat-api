class Api::V1::ChannelsController < ApplicationController
  before_action :set_channel, only: [:show]

  def index
    params[:page] ||= DEFAULT_PAGE

    # available channels = (user) joined channels + unjoined public channels
    joined_channels = Channel.to_payload(
      current_user.channels, 
      params[:page],
      DEFAULT_PER_PAGE,
      joined: true 
    )

    unjoined_public_channels = Channel.to_payload(
      current_user.unjoined_public_channels,
      params[:page],
      DEFAULT_PER_PAGE,
      joined: false 
    )

    json_response(joined_channels.concat(unjoined_public_channels))
  end

  def show
    params[:page] ||= DEFAULT_PAGE

    channel_with_messages = @channel.to_payload(
      params[:page], 
      DEFAULT_PER_PAGE
    )

    json_response(channel_with_messages)
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end
end
