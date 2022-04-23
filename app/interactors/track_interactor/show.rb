class TrackInteractor::Show
    include Interactor

    delegate :id, to: :context

    def call
			context.output = find_track
    end

		private

		def find_track
			Track.find(id)

		rescue ActiveRecord::RecordNotFound
			context.fail!(errors: 'Track not found', error_status: :not_found)
		end
end