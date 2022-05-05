module Api
  module V1
    class ApplicationsController < ApplicationController

      # GET /applications or /applications.json
      def index
        @application = Applications.all
        return render json: {message: "No Applications found. Create one."} unless @application
        @applications_array = Array.new
        @application.each do |app|
          @applications_array << {
            application_token: app.token,
            chats_count: app.chats_count,
            created_at: app.created_at
          }
        end
        render json: @applications_array, status: 200
      end

      def show
        @application = Applications.where(token: params[:id])
        return render json: {message: "No Applications found. Create one."} unless @application
        @applications_array = Array.new
        @application.each do |app|
          @applications_array << {
            application_token: app.token,
            chats_count: app.chats_count,
            created_at: app.created_at
          }
        end
        render json: @applications_array, status: 200
      end

      def show_by_id
        @application = Applications.find_by(id: params[:id])
        if @application
          render json:  @application
        else
          render json: {"error": "This Application not found"}
        end
      end

      def create
        @application = Applications.new(application_params)
        @application.token = Digest::SHA1.hexdigest([Time.now, rand].join)
        @application.chats_count = 0
        if @application.save
          render json: {
              response: "success",
              chat: {
                name: @application.name,
                application_token: @application.token,
                chats_count: @application.chats_count,
                created_at: @application.created_at
              }
          }, status: 200
        else
          render json: {status: :unprocessable_entity, error: @application.errors, data: []}, status: :unprocessable_entity
        end
      end

      def destroy
        @application = Applications.find_by(token: params[:id])
        if @application
          @application.destroy
          render json: "Application Deleted successfuly"
        else
          render json: {status: :unprocessable_entity, error: "Application can't be deleted", data: []}, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /applications/1 or /applications/1.json
      def update
        @application = Applications.find_by(token: params[:id])
        if @application
          @application.update(application_params)
          render json: {status: :ok, error: '', data: {token: @application.token}}, status: :ok
        else
          render json: {status: :unprocessable_entity, error: "Application can't be updated", data: []}, status: :unprocessable_entity
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
  def application_params
    params.permit(:name)
  end