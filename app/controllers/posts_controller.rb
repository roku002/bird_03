class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    tag_names = params[:post][:tag_names].split(",")
    tags = tag_names.map{ |tag_name| Tag.find_or_initialize_by(name: tag_name) }
    tags.each do |tag|
      if tag.invalid?
        @tag_name = params[:tag_name]
        @post.errors.add(:tags, tag.errors.full_messages.join("\n"))
        return render :edit, status: :unprocessable_entity
      end
    end

  @post.tags = tags
    if @post.save
      redirect_to post_path(@post), success: '投稿を作成しました'
    else
      @tag_name = params[:tag_name]
      flash.now[:danger] = '投稿を作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    tag_names = params[:post][:tag_names].split(",")
    tags = tag_names.map { |tag_name| Tag.find_or_create_by(name: tag_name) }
    tags.each do |tag|
      if tag.invalid?
        @tag_name = params[:tag_name]
        @post.errors.add(:tags, tag.errors.full_messages.join("\n"))
        return render :edit, status: :unprocessable_entity
      end
    end

    if @post.update(post_params) && @post.update!(tags: tags)
      redirect_to post_path(@post), success: '投稿を更新しました'
    else
      @tag_name = params[:tag_name]
      flash.now[:danger] = '投稿を更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
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
