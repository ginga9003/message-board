class MessagesController < ApplicationController
  def index
    # Messageをすべて取得する
    @messages = Message.all
    @message = Message.new
  end
  
  def create
    #binding.pry
    @message = Message.new(message_params)
    if @message.save
      # メッセージの保存に成功した場合
      # リダイレクト
      redirect_to root_path , notice: 'メッセージを保存しました'
    else
      # メッセージの保存に失敗した場合
      @messages = Message.all
      flash.now[:alert] = "メッセージの保存に失敗しました"
      render 'index'
    end
  end
  
  private
  def message_params
    # パラメータを受け取る
    # params[:message]のパラメータで name , bodyのみを許可する。
    # 返り値は ex:) {name: "入力されたname" , body: "入力されたbody" }
    params.require(:message).permit(:name, :body)
  end
end
