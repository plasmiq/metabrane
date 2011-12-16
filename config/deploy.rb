$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"     

set :repository,  'git@178.63.75.143:metabrane'
set :scm, :git
set :use_sudo, false
set :app_symlinks, %w(config/database.yml)
set :rvm_type, :user
set :stages, %w(staging beta)
set :default_stage, 'staging'

require 'capistrano/ext/multistage'
require 'bundler/capistrano'

role :web, '178.63.75.143'
role :app, '178.63.75.143'
role :db,  '178.63.75.143', :primary => true

desc 'Symlinks the :app_symlinks'
  task :after_update_code do
  app_symlinks.each do |link|
    run "ln -nfs #{shared_path}/#{link} #{release_path}/#{link}"
  end
end

after "deploy:restart", "deploy:precompile_assets"

