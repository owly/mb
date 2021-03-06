class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :require_owner, only: [:edit, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order('created_at DESC')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments.order('created_at DESC')
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to :root, notice: 'Post was successfully created.' }
        format.json { render :root_path, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
    
     def require_owner
      obj = instance_variable_get("@#{controller_name.singularize.camelize.underscore}") # LineItem becomes @line_item
      if !@user_id
        render_error_message("You must be the #{controller_name.singularize.camelize} owner to access this page", root_url)
        return false
      end
      return true if current_user.id == @user.id
      render_error_message("You must be the #{controller_name.singularize.camelize} owner to access this page", root_url)
      return false
    end
end
