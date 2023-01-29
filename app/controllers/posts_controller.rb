class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    current_user = User.find(params[:user_id])
    @post = Post.new(post_params)
    @post.user = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to user_posts_path(current_user)
    else
      flash.now[:error] = "Error: Couldn't create post"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find_by!(id: params[:id], user_id: params[:user_id])
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id]).destroy
    redirect_to user_path(@user)
    user.decrement!(:posts_counter)
  end

  private

  def post_params
    params.require(:new_post).permit(:title, :text)
  end
end
