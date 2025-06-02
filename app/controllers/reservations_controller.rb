class ReservationsController < ApplicationController
  before_action :set_current_user
  before_action :set_reservation, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index 
    @reservations = current_user.reservations
    #右のようにしなくていける @reservations = current_user.reservations.includes(:room)
  end

  def new
  end

  def create
    #@reservationにはroom_id(hidden扱い)もpermitで渡す(エラーが出る)
    @reservation = current_user.reservations.build(params.require(:reservation).permit(:check_in, :check_out, :number_of_people, :room_id))
    if @reservation.save
      redirect_to :reservations, notice: "施設の予約が完了しました"
    else
      #room_idもparamsに渡す
      @room = Room.find_by(id: params[:reservation][:room_id]) 
      @user = current_user
      flash.now[:alert] = "施設の予約に失敗しました"
      render "rooms/show"
    end
  end

  def confirm
    if params[:reservation][:id].present?
      #①再予約の処理
      @reservation = current_user.reservations.find(params[:reservation][:id])
      @reservation.assign_attributes(params.require(:reservation).permit(:check_in, :check_out, :number_of_people, :room_id))
    else
      #②新規予約の処理
      @reservation = current_user.reservations.build(params.require(:reservation).permit(:check_in, :check_out, :number_of_people, :room_id))
    end
    
    if @reservation.valid?
      #上で①の場合なら、再予約用フォームになる
      #②の場合は、新規予約用フォームになる。
      render :confirm
    else
      if params[:reservation][:id].present?
        flash.now[:alert] = "予約情報が不足しています。"
        render "edit"
      else
        @room = Room.find_by(id: params[:reservation][:room_id]) 
        @user = current_user
        flash.now[:alert] = "予約情報が不足しています。"
        render "rooms/show"
      end
    end
  end

  def edit
  end

  def update
    #こちらではpermitにroom_id不要でいい
    if @reservation.update(params.require(:reservation).permit(:check_in, :check_out, :number_of_people))
      redirect_to :reservations, notice: "予約情報を更新しました"
    else
      flash.now[:alert] = "予約情報の更新に失敗しました"
      render "edit"
    end
  end

  def destroy
    @reservation.destroy
    redirect_to :reservations, notice: "予約を削除しました"
  end

  private
  def set_current_user
    @user = current_user
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def authorize_user!
    unless @reservation.user == current_user
      redirect_to :reservations, alert: "権限がありません。"
    end
  end
end
