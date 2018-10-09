class Application

  def call(env)
    @request = Rack::Request.new(env)
    if @request.path_info == '/time'
      [status, headers, body]
    else
      [404, headers, '404']
    end
  end

  private

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    ["Greetings!!\n"]
  end
end
