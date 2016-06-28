worker_processes ENV['WORKER_PROCESSES'].to_i || 1

listen ENV['LISTEN_ON']

timeout 30

preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end
