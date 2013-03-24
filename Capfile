load "deploy"
load "deploy/assets"

require "bundler/capistrano"
require "rvm/capistrano"

set :application, "mapa76-webapp"

set :user, "mapa"
set :domain, "hhba.info"
set :environment, "production"
set :deploy_to, "/home/mapa/#{application}"

require "capistrano-unicorn"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :normalize_asset_timestamps, false
set :rvm_ruby_string, '1.9.3-p194'
set :rvm_type, :user

set :scm, :git
set :repository, "git://github.com/hhba/mapa76-webapp.git"
set :branch, "master"
set :scm_verbose, true
set :use_sudo, false
set :ssh_options, :forward_agent => true

set :keep_releases, 5

set :config_files, %w{ mongoid resque elasticsearch }

namespace :deploy do
  desc "Symlink config files"
  task :create_symlink_shared do
    config_files.each do |filename|
      run "ln -nfs #{deploy_to}/shared/config/#{filename}.yml #{release_path}/config/#{filename}.yml"
    end
    run "ln -nfs #{deploy_to}/shared/thumbs #{release_path}/public/thumbs"
  end

  task :migrate do
    puts "No migrations"
  end
end

after "deploy:update_code", "deploy:create_symlink_shared"
#after "deploy", "db:mongoid:create_indexes"

after "deploy:restart", "unicorn:reload" # app IS NOT preloaded
#after "deploy:restart", "unicorn:restart"  # app preloaded
