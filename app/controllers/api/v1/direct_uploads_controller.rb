class Api::V1::DirectUploadsController < ApplicationController
  before_action :authenticate_admin!
  

  def create
    response = generate_direct_upload(blob_params);
    render json: response
  end

  private


  def blob_params
    params.require(:file).permit(:filename, :byte_size, :checksum, :content_type, metadata: {})
  end

  def generate_direct_upload(blob_args)
    blob = create_blob(blob_args)
    response = signed_url(blob)
    response[:blob_signed_id] = blob.signed_id
    response
  end

  def create_blob(blob_args)
    blob = ActiveStorage::Blob.create_before_direct_upload!(
      filename: blob_args[:filename],
      byte_size: blob_args[:byte_size],
      checksum: blob_args[:checksum],
      content_type: blob_args[:content_type],
      metadata: blob_args[:metadata]
    )
    pdf_id = SecureRandom.uuid ## generate random id for blob file name
    blob.update_attribute(:key, "uploads/#{pdf_id}") # uploads folder name and file name
    blob
  end

  def signed_url(blob)
    expiration_time = 10.minutes
    response_signature(
      blob.service_url_for_direct_upload(expires_in: expiration_time),
      headers: blob.service_headers_for_direct_upload
    )
  end

  def response_signature(url, **params)
    {
      direct_upload: {
        url: url
      }.merge(params)
    }
  end
end