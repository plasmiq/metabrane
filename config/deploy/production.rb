set :application, :metabrane
set :user, 'metabrane'

namespace :deploy do
  #task :start, :roles => :app, :except => { :no_release => true } do
  #  run "cd #{current_path} && bundle exec passenger start --daemonize --environment production --port 13001"
  #end
  #task :stop, :roles => :app, :except => { :no_release => true } do
  #  run "cd #{current_path} && bundle exec passenger stop --pid-file tmp/pids/passenger.13001.pid"
  #end
  #task :restart, :roles => :app, :except => { :no_release => true } do
  #  run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  #end
  desc "Restart the master unicorn process"
  task :restart do
    stop
    start
  end

  desc "Start unicorn server"
  task :start do
    run "cd #{deploy_to}/current && bundle exec unicorn_rails -c config/unicorn.config -E #{rails_env} -D"
  end

  desc "Stop unicorn server"
  task :stop do
    run "kill `cat #{deploy_to}/shared/pids/unicorn.pid` || true"
  end
  
  desc "precompile the assets"
  task :precompile_assets, :roles => :web, :except => { :no_release => true } do
    run "cd #{current_path}; rm -rf public/assets/*"
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake assets:precompile"
  end
end
