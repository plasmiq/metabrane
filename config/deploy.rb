set :application, :metabrane
set :repository,  'git@178.63.75.143:dieta-bialkowa.git'
set :scm, :git
set :user, 'metabrane'
set :use_sudo, false
set :app_symlinks, %w(config/database.yml)
set :stages, %w(beta)
set :default_stage, 'beta'


role :web, '178.63.75.143'
role :app, '178.63.75.143'
role :db,  '178.63.75.143', :primary => true

desc 'Symlinks the :app_symlinks'
  task :after_update_code do
    app_symlinks.each do |link|
    run "ln -nfs #{shared_path}/#{link} #{release_path}/#{link}"
  end
end

namespace :deploy do
  desc 'Restart Apache'
    task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
