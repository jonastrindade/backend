lock "~> 3.20.0"

set :application, "backend"
set :repo_url, "git@github.com:jonastrindade/backend.git"
set :branch, ENV.fetch("BRANCH", "main")
set :deploy_to, "/var/www/backend"
set :assets_roles, [ :web ]
set :assets_prefix, "assets"
append :linked_files, "config/database.yml", "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"
set :keep_releases, 5
set :ssh_options, {
  user: ENV.fetch("DEPLOY_USER", "deploy"),
  keys: %W[#{ENV['DEPLOY_KEY']}],
  forward_agent: true,
  auth_methods: %w[publickey],
  verify_host_key: :accept_new
}
namespace :puma do
  desc "Restart Puma"
  task :restart do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, :puma
    end
  end
end
after "deploy:publishing", "puma:restart"
