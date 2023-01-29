class CommentsController < ApplicationController
  def new
    @commment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: @comment } }
    end
  end

  def create
    post_creator = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = post
    if @comment.save
      flash[:notice] = 'Comment created successfully'
      redirect_to user_post_path(post_creator, post)
    else
      flash.now[:error] = "Error: Couldn't create comment"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id]).destroy
    redirect_to user_post_path(@user, @post)
    @post.decrement!(:comments_counter)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
