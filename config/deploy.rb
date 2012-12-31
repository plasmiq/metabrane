#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
load "deploy/assets"

require "rvm/capistrano"
require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :repository,  'git@178.63.75.143:metabrane'
set :scm, :git
set :use_sudo, false
set :app_symlinks, %w(config/database.yml config/unicorn.config)
set :rvm_type, :user
set :rvm_ruby_string, "1.9.3"
set :stages, %w(staging production)
set :default_stage, 'staging'


role :web, '178.63.75.143'
role :app, '178.63.75.143'
role :db,  '178.63.75.143', :primary => true

desc 'Symlinks the :app_symlinks'
  task :after_update_code do
  app_symlinks.each do |link|
    run "ln -nfs #{shared_path}/#{link} #{release_path}/#{link}"
  end
end
