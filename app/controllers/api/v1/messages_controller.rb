module Api
  module V1
    class MessagesController < ApplicationController
      before_action :set_chat , only: [:create]
      before_action :set_application, only: [:create]
      def index
          chat_token = params.require(:chat_id)
          @messages = Message.where(number: chat_token)

          return render json: {message: "No Messaages found. Create one."} unless @messages
          @messages_array = Array.new
          @messages.each do |message|
            @messages_array << {
              message_number: message.number,
              created_at: message.created_at
            }
          end
          render json: @messages_array, status: 200
      end

      def create
        number = @chat.messages_count + 1
        @chat.update(messages_count: number)

        @message = Message.new(chat_id: params[:chat_id], body: params[:body])
        @message.number = number
        if @message.save
            render json: {
                response: "success",
                chat: {
                    message_number: number,
                    body: @message.body,
                    created_at: @message.created_at
                }
            }, status: 200
        else
            render json: {status: :unprocessable_entity, error: @message.errors, data: []}, status: :unprocessable_entity
        end
      end

      def destroy
        @chat = Message.find_by(number: params[:id])
        if @chat
            @chat.destroy
          render json: "Message Deleted successfuly"
        else
          render json: {status: :unprocessable_entity, error: "Message can't be deleted", data: []}, status: :unprocessable_entity
        end
      end    

    end
  end
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_application
    @application = Applications.where(token: params[:application_id]).first
    if !@application
        render json: {status: :not_found, error: 'Application not found', data: []}, status: :not_found
     end
  end

  def set_chat
    @chat = Chat.where(number: params[:chat_id]).first
    if !@chat
        render json: {status: :not_found, error: 'Chat not found', data: []}, status: :not_found
    end
  end

  # Only allow a list of trusted parameters through.
  def chat_params
    params.permit(:token)
  end

