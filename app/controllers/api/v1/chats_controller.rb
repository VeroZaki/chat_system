module Api
    module V1
        class ChatsController < ApplicationsController
            def index
                application_token = params.require(:application_id)
                @chats = Chat.where(application_id: application_token)

                return render json: {message: "No chats found. Create one."} unless @chats
                @chats_array = Array.new
                @chats.each do |chat|
                  @chats_array << {
                    chat_number: chat.number,
                    application_token: chat.application_id,
                    messages_count: chat.messages_count,
                    created_at: chat.created_at
                  }
                end
                render json: @chats_array, status: 200
            end
        
            def create
                application_token = params.permit(:application_id)

                @chat = Chat.new(application_token)
                if @chat.save
                    render json: {
                        response: "success",
                        chat: {
                            chat_number: @chat.number,
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
                  render json: "Application Deleted successfuly"
                else
                  render json: {status: :unprocessable_entity, error: "Application can't be deleted", data: []}, status: :unprocessable_entity
                end
              end
        end        
    end
end    

private
  # Use callbacks to share common setup or constraints between actions.
  def set_application
    @application = Applications.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def chat_params
    params.permit(:token)
  end