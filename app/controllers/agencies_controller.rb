class AgenciesController < ApplicationController
  before_action :authenticate_user!, except: [ :welcome ]
  authorize_resource except: [:welcome ]
  #before_filter :load_agency_from_subdomain
  
  def welcome
    
  end
  
end
