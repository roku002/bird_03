class BoardsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @boards = Board.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @board = Board.new
  end

  def show
    @board = Board.find(params[:id])
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: '掲示板を作成しました'
    else
      flash.now[:danger] = '掲示板を作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      redirect_to board_path(@board), success: '掲示板を更新しました'
    else
      flash.now[:danger] = '掲示板を更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board = current_user.boards.find(params[:id])
    @board.destroy!
    redirect_to boards_path, success: '掲示板を削除しました', status: :see_other
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
