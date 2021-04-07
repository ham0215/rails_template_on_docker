class UsersController < ApplicationController
  def index
    # 未定義のモジュール呼び出し
    raise AppError.new('hogehoge')
  end
end
