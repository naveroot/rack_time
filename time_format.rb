class TimeFormat
  TIME_HASH = {
      year: 'year',
      month: 'month',
      day: 'day',
      hour: 'hour',
      minute: 'min',
      second: 'sec'
  }.freeze

  attr_reader :output

  def initialize(params)
    @params = params
    @output = []
    @format_params = params['format'].split(',')
    time_output if format_valid?
  end

  def format_valid?
    unexpected_params.empty? && !@params['format'].empty? && !@params['format'].nil?
  end

  def unexpected_params
      (@format_params - TIME_HASH.keys.map(&:to_s))
  end

  private

  def time_output
    @format_params.each do |param|
      @output << Time.now.send(TIME_HASH[param.to_sym])
    end
  end
end