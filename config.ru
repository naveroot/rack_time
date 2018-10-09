require_relative 'middleware/runtime'
require_relative 'middleware/logger'
require_relative 'middleware/time_format'
require_relative 'app'

use Rack::Reloader
use Runtime
use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
use TimeFormat

run Application.new
