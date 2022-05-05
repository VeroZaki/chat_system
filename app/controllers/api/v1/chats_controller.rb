module Api
    module V1
        class ChatsController < ApplicationsController
            before_action :set_application, only: [:create, :destroy]
            def index
              application_token = params.require(:application_id)
              @chats = Chat.where(application_id: application_token)

              return render json: {message: "No chats found. Create one."} unless @chats
              @chats_array = Array.new
              @chats.each do |chat|
                @chats_array << {
                  id: chat.id,
                  chat_number: chat.number,
                  application_token: chat.application_id,
                  messages_count: chat.messages_count,
                  created_at: chat.created_at
                }
              end
              render json: @chats_array, status: 200
            end
        
            def show 
              application_token = params.require(:application_id)
                @chats = Chat.where(application_id: application_token, number: params[:id])

                return render json: {message: "No chats found. Create one."} unless @chats
                @chats_array = Array.new
                @chats.each do |chat|
                  @chats_array << {
                    id: chat.id,
                    chat_number: chat.number,
                    application_token: chat.application_id,
                    messages_count: chat.messages_count,
                    created_at: chat.created_at
                  }
                end
              render json: @chats_array, status: 200
            end

            def create
                number = @application.chats_count + 1
                @application.update(chats_count: number)

                @chat = Chat.new(application_id: params[:application_id])
                @chat.number = number
                if @chat.save
                    render json: {
                        response: "success",
                        chat: {
                            chat_number: number,
                            application_id: @chat.application_id,
                            messages_count: @chat.messages_count,
                            created_at: @chat.created_at
                        }
                    }, status: 200
                else
                    render json: {status: :unprocessable_entity, error: @chat.errors, data: []}, status: :unprocessable_entity
                end
            end

            def destroy
                @chat = Chat.find_by(number: params[:id])
                if @chat
                  @chat.destroy
                  number = @application.chats_count - 1
                  @application.update(chats_count: number)

                  render json: "Chat Deleted successfuly"
                else
                  render json: {status: :unprocessable_entity, error: "Chat can't be deleted", data: []}, status: :unprocessable_entity
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

  # Only allow a list of trusted parameters through.
  def chat_params
    params.permit(:token)
  end

  def set_chat
    @chat = @app.chats.where(number: params[:id]).first
    if !@chat
        render json: {status: :not_found, error: 'Chat not found', data: []}, status: :not_found
    end
  end