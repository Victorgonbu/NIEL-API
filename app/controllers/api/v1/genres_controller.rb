class Api::V1::GenresController < ApplicationController
  skip_before_action :authenticate_token!
  def index
    initialize_render_concern(genre_index_interactor)

    render_result_serializer(index: true)
  end

  def show
    initialize_render_concern(genre_show_interactor, :output, options)

    render_result_serializer
  end

  private

  def genre_show_interactor
    GenreInteractor::Show.call(
      options: options,
      slug: params[:slug]
    )
  end

  def genre_index_interactor
    GenreInteractor::Index.call(params: params)
  end

  def options
    {include: [:tracks]}
  end
end