class Api::V1::LicensesController < ApplicationController 
  
  def index
    @licenses = License.all.includes(:orders)
    render json: LicenseSerializer.new(@licenses).serializable_hash.to_json, status: 200
  end
end