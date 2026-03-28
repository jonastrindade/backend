# Configuração de produção para Puma + Capistrano

# Diretório atual da aplicação (Capistrano cria /current)
directory "/var/www/backend/current"
rackup "/var/www/backend/current/config.ru"
environment "production"

# PID e state persistentes
pidfile "/var/www/backend/shared/tmp/pids/puma.pid"
state_path "/var/www/backend/shared/tmp/pids/puma.state"

# Logs persistentes
stdout_redirect "/var/www/backend/shared/log/puma.stdout.log", "/var/www/backend/shared/log/puma.stderr.log", true

# Bind Unix socket para Nginx
bind "unix:///var/www/backend/shared/tmp/sockets/puma.sock"

# Número de workers e threads
workers 2
threads 1, 6

# Roda em background
daemonize true

# Permite reiniciar com `bin/rails restart`
plugin :tmp_restart
