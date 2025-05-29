class ApplicationController < ActionController::Base
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