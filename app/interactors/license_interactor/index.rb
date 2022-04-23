class LicenseInteractor::Index
  include Interactor
  include Pagy::Backend

  def call
    context.output = get_all_licenses
  end

  delegate :params, to: :context

  private

  def get_all_licenses
    context.pagy, licenses = pagy(
      License.all,
      items: params[:limit]
    )
    
    licenses
  end
end