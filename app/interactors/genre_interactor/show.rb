class GenreInteractor::Show
  include Interactor

  def call
    context.output = get_genre
  end

  delegate :slug, to: :context

  private

  def get_genre
    Genre.find_by_slug!(slug)

  rescue ActiveRecord::RecordNotFound
    context.fail!(errors: 'Genre not found', error_status: :not_found)
  end
end