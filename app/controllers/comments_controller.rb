class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :create, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post, notice: 'Comment was successfully created.' }
        format.json { render :root_path, status: :created, location: @comment }
      else
        flash[:error]= 'Error creating comment'
        format.html { redirect_to @comment.post }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :body, :user_id)
    end
  
end
