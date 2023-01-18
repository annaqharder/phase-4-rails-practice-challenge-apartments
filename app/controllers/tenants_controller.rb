class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        tenants = Tenant.all
        render json: tenants, status: :ok
    end

    def show
        tenant = find_tenant
        render json: tenant, status: :ok
    end

    def create
        tenant = tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = find_tenant
        tenant.update!(tenant_params)
        render json: tenant, status: :accepted
    end

    def destroy
        tenant = find_tenant
        tenant.destroy
        head :no_content
    end


    private

    def find_tenant
        tenant = Tenant.find(params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def render_not_found(record)
        render json: { errors: "#{record.model} Not Found"}, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

end
