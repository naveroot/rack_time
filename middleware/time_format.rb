class TimeFormat
  AVAILABLE_TIME_FORMATS = %w[year month day hour minute second].freeze
  TIME_HASH = {
    year: 'year',
    month: 'month',
    day: 'day',
    hour: 'hour',
    minute: 'min',
    second: 'sec'
  }.freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    request = Rack::Request.new(env)
    params = request.params
    return [404, headers, ['Not found']] if valid_url?
    format_params = params['format'].split(',')
    if formats_valid?(format_params)
      [500, headers, [time_output(format_params)]]
    else
      [400, headers, ["Unknown time format [#{(format_params - AVAILABLE_TIME_FORMATS).join(',')}]"]]
    end
  end

  private
  def valid_url?
    params['format'].nil? || params['format'].empty? || request.path_info != '/time'
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
