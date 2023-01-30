class MessagesController < ApplicationController
  before_action :authenticate_chef!

  def create
    @message = Message.new message_params
    @message.chef = current_chef

    if @message.save
      ActionCable.server.broadcast "chatroom", message: render_message(@message), chef: @message.chef.chefname
    else
      flash[:danger] = "We're sorry, there was a problem creating your message"
      redirect_to chat_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message message
    render(partial: "message", locals: {message: message})
  end
end
