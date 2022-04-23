module RenderConcern
    def initialize_render_concern(result, output = :output, options = {})
        @result = result
        @output = result.send(output)
        @success_status = result.status || options[:success_status] || :ok
        @error_status = result.error_status || options[:error_status] || :bad_request
        @options = result.response_options || options.except(:success_status, :error_status)
        @pagy = result.send(:pagy)
        @serializer = result.response_serializer || serializer_method  
    end

    def render_for_index
        paginate_response_with_serializer(@pagy, @output, @serializer, @success_status, @options)
    end

    def render_for_single
        render json: @serializer.new(@output, @options).serializable_hash.to_json,
           status: @success_status
    end
end