require 'rails_helper'

RSpec.describe "Direct uploads" do
  let(:file) { fixture_file_upload("app/assets/tests/image.png") }
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }

  describe 'Create' do
    context 'when admin user' do 
      it "return object with presigned url and headers" do
        authToken = JsonWebToken.encode(sub: admin.id)

        post '/api/v1/direct_upload', params: {
          file: {
            filename: file.original_filename,
            content_type: 'image/png',
            byte_size: File.size(file.path),
            checksum: Digest::MD5.base64digest(File.read(file.path))
          }
        }, headers: { Authorization: "Bearer #{authToken}"}

        expect(response).to have_http_status(200)
        expect(response_json).to have_key("direct_upload")
        expect(response_json).to have_key("blob_signed_id")
        expect(response_json["direct_upload"]).to be_truthy()
        expect(response_json["blob_signed_id"]).to be_truthy()

      end
    end

    context 'when no admin user' do
      it "return object with error message" do
        authToken = JsonWebToken.encode(sub: user.id)

        post '/api/v1/direct_upload', params: {
          file: {
            filename: file.original_filename,
            content_type: 'image/png',
            byte_size: File.size(file.path),
            checksum: Digest::MD5.base64digest(File.read(file.path))
          }
        }, headers: { Authorization: "Bearer #{authToken}"}

        expect(response).to have_http_status(400)
        expect(response_json["errors"].length).to be(1)
        expect(response_json["errors"][0]).to eq("No valid user")

      end
    end
  end
end