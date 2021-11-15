fd = IO.sysopen("/proc/1/fd/1", "w")
a = IO.new(fd,"w")
a.sync = true # send log message immediately, don't wait
a.puts "starting rapp2z"


require 'sinatra'
require 'date'

set :port, 9000

get '/api' do
  content_type 'text/plain'
  DateTime.now.to_s
end

require 'rack'
require 'zipkin-tracer'

ZIPKIN_TRACER_CONFIG = {
  service_name: 'rapp2z',
  sample_rate: 1.0,
  json_api_host: 'http://zipkin:9411'
}.freeze

use ZipkinTracer::RackHandler, ZIPKIN_TRACER_CONFIG
