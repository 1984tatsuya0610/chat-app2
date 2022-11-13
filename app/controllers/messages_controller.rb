class MessagesController < ApplicationController
  def index
    @message = Message.new #メッセージモデルのインスタンス情報を代入
    @room = Room.find(params[:room_id]) #pasamsに含まれているチャットルームのレコード情報「room_id」を代入
    @messages = @room.messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end

#praivateメソッドとしてmessage_paramsを定義し、
#メッセージの内容contentをmessageテーブルへ保存できる様にする。
#パラメーターの中に、ログインしているユーザーのidと紐付いている、メッセージの内容contentを受け取れるように許可する。
