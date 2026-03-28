environment ENV.fetch("RAILS_ENV") { "development" }

if ENV["RAILS_ENV"] == "production"
  directory "/var/www/backend/current"
end

rackup File.expand_path("config.ru", __dir__)

if ENV["RAILS_ENV"] == "production"
  pidfile "/var/www/backend/shared/tmp/pids/puma.pid"
  state_path "/var/www/backend/shared/tmp/pids/puma.state"
end

if ENV["RAILS_ENV"] == "production"
  stdout_redirect "/var/www/backend/shared/log/puma.stdout.log",
                  "/var/www/backend/shared/log/puma.stderr.log",
                  true
end

if ENV["RAILS_ENV"] == "production"
  bind "unix:///var/www/backend/shared/tmp/sockets/puma.sock"
else
  port 3000
end

if ENV["RAILS_ENV"] == "production"
  workers ENV.fetch("WEB_CONCURRENCY", 2)
else
  workers 0
end

threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
threads threads_count, threads_count

plugin :tmp_restart
