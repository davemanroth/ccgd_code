# config valid only for current version of Capistrano
lock "3.6.1"

set :application, "ccgd"
set :repo_url, "git@bitbucket.org:hccadmin/ccgd.git"
set :stage, :production

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/html/ccgd"

# Set deployment method
set :deploy_via, :copy

# Default value for :scm is :git
set :scm, :git

# Set environment
set :rails_env, "production"

# Set number of stored releases
set :keep_releases, 5

# Any ssh password prompts appear in terminal
# default_run_options[:pty] = true

set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
#
