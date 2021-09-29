module RequestHelpers
  def response_json
    JSON.parse(response.body)
  end

  def track_have_base_attributes(attributes)
    expect(attributes.keys).to include('buyable', 'name', 'bpm', 'pcm', 'relatedTracks')
    expect(attributes['imageFile']).not_to be_empty()
    expect(attributes['mp3File']).not_to be_empty()
  end
end