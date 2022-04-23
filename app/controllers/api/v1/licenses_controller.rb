class Api::V1::LicensesController < ApplicationController
  def index
    initialize_render_concern(lincense_index_interactor)

    render_result_serializer(index: true)
  end

  private

  def lincense_index_interactor
    LicenseInteractor::Index.call(params: params)
  end
end