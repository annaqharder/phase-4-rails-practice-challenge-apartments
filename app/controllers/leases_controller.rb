class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create
        lease = lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = find_lease
        lease.destroy
        head :no_content
    end


    private

    def find_lease
        lease = lease.find(params[:id])
    end

    def lease_params
        params.permit(:rent)
    end

    def render_not_found(record)
        render json: { errors: "#{record.model} Not Found"}, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end


end
