class Api::V1::ChannelsController < ApplicationController
  before_action :set_channel, only: [:show]

  default_page 1
  default_per_page 10

  def index
    params[:page] ||= default_page

    # available channels = (user) joined channels + unjoined public channels
    joined_channels = Channel.to_payload(
      current_user.channels, 
      params[:page],
      default_per_page,
      joined: true 
    )

    unjoined_public_channels = Channel.to_payload(
      current_user.unjoined_public_channels,
      params[:page],
      joined: false 
    )
    
    json_response(joined_channel.concat(unjoined_public_channels))
  end

  def show
    params[:page] ||= default_page

    channel_with_messages = @channel.to_payload(
      parmas[:page], 
      default_per_page
    )

    json_response(channel_with_messages)
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end
end
