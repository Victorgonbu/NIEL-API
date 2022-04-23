module RequestHelpers
  def response_json
    @response_json ||= JSON.parse(response.body).with_indifferent_access
  end

  def index_result_json
    response_json[:results][:data]
  end

  def track_have_base_attributes(attributes)
    expect(attributes.keys).to include('buyable', 'name', 'bpm', 'pcm', 'relatedTracks')
    expect(attributes['imageFile']).not_to be_empty()
    expect(attributes['mp3File']).not_to be_empty()
  end

  def build_auth_header(user)
    {Authorization: "Bearer #{auth_token_mock(user)}"}
  end

  def auth_token_mock(user)
    @auth_token_mock ||= JsonWebToken.encode(sub: user.id)
  end
#
  #def track_params
  #  {
  #    genres: [Genre.last.id],
  #    track: {
  #      name: 'track name',
  #      bpm: 100,
  #      pcm: '[1, 0, 3, 4]',
  #      buyable: true,
  #      mp3_file: Rack::Test::UploadedFile.new('app/assets/tests/mp3.mp3', 'audio/mp3'),
  #      wav_file: Rack::Test::UploadedFile.new('app/assets/tests/wav.wav', 'audio/wav'),
  #      image_file: Rack::Test::UploadedFile.new('app/assets/tests/image.png', 'image/png'),
  #      zip_file: Rack::Test::UploadedFile.new('app/assets/tests/zip.zip', 'file/zip')
  #    }
  #  }
  #end
end