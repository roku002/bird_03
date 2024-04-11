class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    redirect_to posts_path, success: 'いいねしました！'
  end

  def destroy
    post = current_user.likes_posts.find(params[:post_id])
    current_user.unlike(post)
    redirect_to posts_path, success: 'いいねを解除しました'
  end
end
