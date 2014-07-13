class BetaCommentsController < ApplicationController
  
  # GET /animals/new
  def new
    @beta_comment = BetaComment.new
  end


  # POST /animals
  # POST /animals.json
  def create
    @beta_comment = BetaComment.new(beta_comment_params)
    
    respond_to do |format|
      if @beta_comment.save 
        format.js
      else
        format.js
        format.html { render action: 'new' }
        format.json { render json: @beta_comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
    def beta_comment_params
      params.require(:beta_comment).permit(:comment, :page_url, :user_id, :name, :email )
    end
  
  
end
