class Api::V1::SearchController < ApplicationController
  def query
    users = User.where("username ILIKE ?", "%#{params[:search_input]}%")
    channels = Channel.where("name ILIKE ?", "%#{params[:search_input]}%")
    json_response({users: users, channels: channels})
  end
end
