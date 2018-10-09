class Application
  AVAILABLE_TIME_FORMATS = %w[year month day hour minute second].freeze
  TIME_HASH = {
      year: 'year',
      month: 'month',
      day: 'day',
      hour: 'hour',
      minute: 'min',
      second: 'sec'
  }.freeze

  def call(env)
    request = Rack::Request.new(env)
    params = request.params
    return [404, headers, ['Not found']] if valid_url?(request)
    format_params = params['format'].split(',')
    if formats_valid?(format_params)
      [500, headers, [time_output(format_params)]]
    else
      [400, headers, ["Unknown time format [#{(format_params - AVAILABLE_TIME_FORMATS).join(',')}]"]]
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
    request.params['format'].nil? || request.params['format'].empty? || request.path_info != '/time'
  end

  def formats_valid?(format_params)
    (format_params - AVAILABLE_TIME_FORMATS).empty?
  end

  def time_output(format_params)
    output = []
    format_params.each do |param|
      output << Time.now.send(TIME_HASH[param.to_sym])
    end
    p output.join('-')
  end
end
