class CommentsChannel < ApplicationCable::Channel
  def subscribed
    # @board = Board.find(params[:board_id]) # board_idでボードを見つける
    # stream_from "comments_channel_#{@board.id}" # boardごとにストリーミング
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
