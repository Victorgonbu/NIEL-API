class Api::V1::DirectUploadsController < ApplicationController
  before_action :authenticate_admin!
  
  def create
    response = DirectUpload::Generate.call(blob_params) #generate_direct_upload(blob_params);
    render json: response
  end

  private

  def blob_params
    params.require(:file).permit(:filename, :byte_size, :checksum, :content_type, metadata: {})
  end
end