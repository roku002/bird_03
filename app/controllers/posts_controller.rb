class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @posts = if params[:tag_names]
               Post.joins(:tags).where(tags: { name: params[:tag_names] }).includes(:user).order(created_at: :desc).page(params[:page])
             else
               Post.includes(:user).order(created_at: :desc).page(params[:page])
             end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
    @tag_names = @post.tags.map(&:name).join(", ")
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_names = params[:tag_names].split(",")

    if @post.save
      @post.save_tags(tag_names)
      redirect_to post_path(@post), success: '投稿を作成しました'
    else
      flash.now[:danger] = '投稿を作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    tag_names = params[:tag_names].split(",")
    tags = tag_names.map { |tag_name| Tag.find_or_create_by(name: tag_name) }

    tags.each do |tag|
      next unless tag.invalid?

      @tag_names = params[:tag_names]
      @post.errors.add(:tags, tag.errors.full_messages.join("\n"))
      return render :edit, status: :unprocessable_entity
    end

    if @post.update(post_params) && @post.update!(tags:)
      redirect_to post_path(@post), success: '投稿を更新しました'
    else
      @tag_names = params[:tag_names]
      flash.now[:danger] = '投稿を更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, success: '投稿を削除しました', status: :see_other
  end

  def likes
    @like_posts = current_user.like_posts.includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :image_cache)
  end
end
