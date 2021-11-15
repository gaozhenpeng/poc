require 'jaeger/client'

fd = IO.sysopen("/proc/1/fd/1", "w")
a = IO.new(fd,"w")
a.sync = true # send log message immediately, don't wait
a.puts "starting rapp2j"

OpenTracing.global_tracer = Jaeger::Client.build(host: 'jaeger',
  port: 6831, service_name: 'rapp2j')

OpenTracing.start_active_span('span name') do
  # do something
  a.puts "outer loop span name"
  sleep 2

  loop do
	OpenTracing.start_active_span('inner span name') do
	  # do something else
	  a.puts "inner loop span name"
      sleep 2
	end
  end
end
