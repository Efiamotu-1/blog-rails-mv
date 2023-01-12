class LikesController < ApplicationController
  def create
    current_user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    @like = Like.new(user: current_user, post:)
    if @like.save
      flash[:success] = 'Like created successfully'
    else
      flash[:error] = 'Like not created'
    end
    redirect_to user_post_path(current_user, post)
  end
end
