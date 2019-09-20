class DownloadsController < ApplicationController
  def index
    send_data(StringIO.new('hogehoge').read, type: 'text/plain', filename: 'hogehoge.txt')
  end
end
