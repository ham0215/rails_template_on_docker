class AppError < StandardError
  include ActiveSupport::ActionableError

  action 'Send error message to slack' do
    uri = URI.parse("https://hooks.slack.com/services/xx") # TODO: slack uri
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data(payload: '{"text": "hogehoge"}')
    res = http.request(req)
  end
end
