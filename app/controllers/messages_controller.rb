class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :destroy]  # edit, update, destroyの処理の前にmessageを設定する
  
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
  
  def edit
  end
  
  def update
    #binding.pry
    if @message.update(message_params)
      # 更新に成功した場合
      # リダイレクト
      redirect_to root_path , notice: 'メッセージを編集しました'
    else
      # 更新に失敗した場合
      render 'edit'
    end
  end
  
  def destroy
    @message.destroy
    redirect_to root_path , notice: 'メッセージを削除しました'
  end
  
  private
  def message_params
    # パラメータを受け取る
    # params[:message]のパラメータで name ,age, bodyのみを許可する。
    # 返り値は ex:) {name: "入力されたname" , age: "入力されたage", body: "入力されたbody" }
    params.require(:message).permit(:name, :age, :body)
  end
  
  def set_message
    @message = Message.find(params[:id])

    if params.has_key?(:message)
      @return = params[:message][:return]
      
      #binding.pry
      if @return.to_i == 1
        # 戻る
        redirect_to root_path
      end
    end
  end
end
