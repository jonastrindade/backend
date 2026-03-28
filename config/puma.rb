environment ENV.fetch("RAILS_ENV") { "development" }

threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
threads threads_count, threads_count

workers ENV.fetch("WEB_CONCURRENCY", 2) if ENV["RAILS_ENV"] == "production"

if ENV["RAILS_ENV"] == "production"
  pidfile "/var/www/backend/shared/tmp/pids/puma.pid"
  state_path "/var/www/backend/shared/tmp/pids/puma.state"
end

if ENV["RAILS_ENV"] == "production"
  stdout_redirect "/var/www/backend/shared/log/puma.stdout.log",
                  "/var/www/backend/shared/log/puma.stderr.log",
                  true

  bind "unix:///var/www/backend/shared/tmp/sockets/puma.sock"

  preload_app!
end

plugin :tmp_restart
