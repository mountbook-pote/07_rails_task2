class RoomsController < ApplicationController
  before_action :set_current_user   #roomアクションで、常に@user = current_userを渡すためのコード
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def own
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(params.require(:room).permit(:name, :content, :price, :adress, :image))
    if @room.save
      redirect_to :rooms_own, notice: "施設を作成しました"
    else
      flash.now[:alert] = "施設の作成に失敗しました"
      render "new"
    end
  end

  def show
    @reservation = Reservation.new #ホテルの詳細画面を開くと予約の投稿枠ができる
  end

  def edit
  end

  def update
    if @room.update(params.require(:room).permit(:name, :content, :price, :adress, :image))
      redirect_to :rooms_own, notice: "施設情報を更新しました"
    else
      flash.now[:alert] = "施設情報の更新に失敗しました"
      render "new"
    end
  end

  def destroy
    @room.destroy
    redirect_to :rooms_own, notice: "施設を削除しました"
  end

  private
  def set_current_user
    @user = current_user
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def authorize_user!
    unless @room.user == current_user
      redirect_to :rooms_own, alert: "権限がありません。"
    end
  end
 

end
