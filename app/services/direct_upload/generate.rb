class DirectUpload::Generate
  
  def self.call(blob_args)
    blob = create_blob(blob_args)
    response = signed_url(blob)
    response[:blob_signed_id] = blob.signed_id
    response
  end

  private

  def self.create_blob(blob_args)
    blob = ActiveStorage::Blob.create_before_direct_upload!(
      filename: blob_args[:filename],
      byte_size: blob_args[:byte_size],
      checksum: blob_args[:checksum],
      content_type: blob_args[:content_type],
      metadata: blob_args[:metadata]
    )
    file_uuid = SecureRandom.uuid
    blob.update_attribute(:key, "uploads/beats/#{file_uuid}") # uploads folder name and file name
    blob
  end

  def self.signed_url(blob)
    expiration_time = 20.minutes
    response_signature(
      blob.service_url_for_direct_upload(expires_in: expiration_time),
      headers: blob.service_headers_for_direct_upload
    )
  end

  def self.response_signature(url, **params)
    {
      direct_upload: {
        url: url
      }.merge(params)
    }
  end
end