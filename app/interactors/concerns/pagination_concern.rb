module PaginationConcern
    extend ActiveSupport::Concern
  
    included do
      def paginate_response(pagy_info, results)
        render json: {
          info: pagy_info(pagy), results: results
        }
      end
  
      def pagy_info(pagy)
        {
          page_size: pagy.vars[:"items"].to_i,
          page_index: pagy.page,
          total: pagy.count,
          page_start: pagy.from,
          page_end: pagy.to,
          pages_total: pagy.pages
        } 
      end
  
      def paginate_response_with_serializer(pagy, results, serializer, success_status, options = {})
        render json: {
          info: pagy_info(pagy),
          results: "#{serializer}".constantize.new(results, options).serializable_hash.as_json
        },
        status: success_status
      end
    end
  end
  