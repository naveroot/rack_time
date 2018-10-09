require_relative 'time_format'

class Application

  def call(env)
    request = Rack::Request.new(env)
    params = request.params
    return [404, headers, ['Not found']] unless valid_url?(request)
    time = TimeFormat.new(params)
    if time.format_valid?
      return [200, headers, [time.output.join('-')]]
    else
      return [400,headers,["Unknown time format [#{time.unexpected_params.join(',')}]"]]
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

  def valid_url?(request)
    request.path_info == '/time'
  end
end
