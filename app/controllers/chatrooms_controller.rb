class ChatroomsController < ApplicationController
  before_action :authenticate_chef!

  def show
    @message = Message.new
    @messages = Message.most_recent
  end
end
