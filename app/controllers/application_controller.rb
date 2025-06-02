class ApplicationController < ActionController::Base
before_action :set_search

def set_search
  #application_controllerで書くことで、どのビューからでも検索フォームを出せる
  @q = Room.ransack(params[:q])
end
end

=begin
  #「不正なCSRFトークンを受け取ったら、
  #例外を発生させてリクエストを拒否する」という、
  #セキュリティのための指定です。
  protect_from_forgery with: :exception

  # ログイン済ユーザーのみにアクセスを許可する
  # 未ログイン時の検索結果などで引っかかったら見直す
  before_action :authenticate_user!
=end