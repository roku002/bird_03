class CommentsController < ApplicationController
  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def update
    @comment = current_user.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("comment-#{@comment.id}", partial: 'comments/comment', locals: { comment: @comment }),
            turbo_stream.remove("comment-edit-#{@comment.id}") # ここで編集フォームを削除
          ]
        end
        format.html { redirect_to board_path(@comment.board) }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("comment-edit-#{@comment.id}", partial: "comments/edit_comment_form", locals: { comment: @comment })
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end
