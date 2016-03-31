# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'symfony-demo'
set :repo_url, 'git@github.com:lechinoix/symfony-demo.git'

set :ssh_user, 'ubuntu'
server '62.4.19.72', user: fetch(:ssh_user), roles: %w{web app db}

set :scm, :git

set :format, :pretty

# set :log_level, :debug
set :log_level, :info

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/myapp'

set :permission_method, true

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing do
    task :setpermissions do
      sh 'sudo chmod -R 777 /var/www/myapp'
    end
    task :restartfpm do
      sh 'sudo service php5-fpm restart'
    end
    task :testingsomethig do
      sh 'echo "this is a test" > /var/www/myapp/test'
    end
  end

end
