class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    #household = Household.find(params[:household_id])
    @activities = PublicActivity::Activity.order("created_at desc")
    #need to restrict the feed to household activities
    #where(owner_id: current_user.household.user_ids)
  end
end
