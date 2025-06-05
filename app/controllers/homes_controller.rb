class HomesController < ApplicationController
  def top
    @user = current_user
    #未ログイン時には、@user_nilになるだけで、それだけだとエラーにはならないそう(ビュー次第)
  end
end
