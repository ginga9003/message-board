class MessagesController < ApplicationController
  def index
    # Messageをすべて取得する
    @messages = Message.all
  end
  
  def create
    @message = Message.new(message_params)
    @message.save
    
    # リダイレクト
    redirect_to root_path , notice: 'メッセージを保存しました'
  end
  
  private
  def message_params
    # パラメータを受け取る
    # params[:message]のパラメータで name , bodyのみを許可する。
    # 返り値は ex:) {name: "入力されたname" , body: "入力されたbody" }
    params.require(:message).permit(:name, :body)
  end
end
