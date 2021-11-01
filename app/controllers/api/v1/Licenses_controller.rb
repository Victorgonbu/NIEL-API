class Api::V1::LicensesController < ApplicationController 
  
  def index
    @licenses = License.all

    
  end
end