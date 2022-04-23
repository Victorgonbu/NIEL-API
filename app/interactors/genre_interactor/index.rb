class GenreInteractor::Index
  include Interactor
  include Pagy::Backend

  def call
    context.output = get_all_genres
  end

  delegate :params, to: :context

  private

  def get_all_genres
    context.pagy, genres = pagy(
      Genre.all,
      items: params[:limit]
    )

    genres
  end
end