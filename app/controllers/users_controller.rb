class UsersController < ApplicationController
#userの要素を表示させるだけの、静的なページのコントローラなので、devise用controller等と分けてこっちで書いている
  def account
    @user = current_user
  end

  def profile
    @user = current_user
  end
end
