$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"     

set :application, :metabrane
set :repository,  'git@178.63.75.143:metabrane'
set :scm, :git
set :user, 'metabrane'
set :use_sudo, false
set :app_symlinks, %w(config/database.yml)
set :rvm_type, :user
#set :stages, %w(beta)
#set :default_stage, 'beta'


role :web, '178.63.75.143'
role :app, '178.63.75.143'
role :db,  '178.63.75.143', :primary => true

desc 'Symlinks the :app_symlinks'
  task :after_update_code do
  app_symlinks.each do |link|
    run "ln -nfs #{shared_path}/#{link} #{release_path}/#{link}"
  end
end

desc "precompile the assets"
task :precompile_assets, :roles => :web, :except => { :no_release => true } do
  run "cd #{current_path}; rm -rf public/assets/*"
  run "cd #{current_path}; RAILS_ENV=production bundle exec rake assets:precompile"
end

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec passenger start --daemonize --environment production --port 13001"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec passenger stop --pid-file tmp/pids/passenger.13001.pid"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end
