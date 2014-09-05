class PagesController < ApplicationController
  
  def privacy_policy
    
  end
  
  def about
    
  end
  
  def contact
    
  end
  
  def learn_more
    @learn_about = params[:learn_about]
    
    respond_to do |format|
      format.js 
      format.html
    end
  end
  
  def news
    
  end
  
  def features
    
  end
  
end
