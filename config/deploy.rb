default_run_options[:pty] = true
set :application, "friendne.ws"

## deploy permissions
set :user, "deployer"
set :group, "www-data"
set :use_sudo, false

## deploy strategy
set :scm, "git"
set :repository,  "git@github.com:sthorpe/fb-start.git"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{application}"
set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"

## deploy locations
ip_address = "204.232.193.105"
role :app, ip_address
role :web, ip_address
role :db,  ip_address, :primary => true

ssh_options[:port] = 22
ssh_options[:keys] = "./config/deploy.key"


after "deploy", :set_permissions
after "deploy", :clean_up_web
after "set_permissions", "nginx:reload"
after "nginx:reload", :link_database_yml

# =============================================================================
# POST-DEPLOYMENT TASKS
# =============================================================================
# These tasks are run after the deploy task has completed and do general cleanup
# such as resetting file permissions and creating necessary symlinks.

desc "Sets filesystem permissions on the checked-out code."
task :set_permissions, :roles => :app do
  sudo "chown -R #{user}:#{group} #{current_path}/"
  sudo "chown -R #{user}:#{group} #{shared_path}/log"
  sudo "chmod 0666 #{current_path}/log/*"
end

desc "Links the production database.yml"
task :link_database_yml, :roles => :app do
  run "ln -nfs #{current_path}/config/database.yml.production #{current_path}/config/database.yml"
end

desc "Removes the maintainace page"
task :clean_up_web, :roles => :app do
  run "rm #{deploy_to}/#{current_dir}/public/system"
end

##
# Cleanup
#
namespace(:deploy) do
  desc <<-DESC
Removes unused releases from the releases directory. By default, the last 5
releases are retained, but this can be configured with the 'keep_releases'
variable. This will use run to do the delete, not sudo.
DESC
  task :cleanup do
    count = (self[:keep_releases] || 5).to_i
    if count >= releases.length
      logger.important "no old releases to clean up"
    else
      logger.info "keeping #{count} of #{releases.length} deployed releases"
      directories = (releases - releases.last(count)).map { |release|
        File.join(releases_path, release) }.join(" ")
 
      run "rm -rf #{directories}"
    end
  end
  
  desc "Restarts the mongrel cluster. Should be run after the deploy task."
  task :restart do
    mongrel.restart
  end
end

# =============================================================================
# MONGREL TASKS
# =============================================================================
# These tasks can be used to manipulate the mongrel clusters on the server (restart, etc).
namespace(:mongrel) do
  desc "The spinner task is used by :cold_deploy to start the application up"
  task :spinner, :roles => :app do
    send(run_method, "cd #{deploy_to}/#{current_dir} && sudo mongrel_rails cluster::start")
  end

  desc "Restart the mongrel cluster"
  task :restart, :roles => :app do
    send(run_method, "cd #{deploy_to}/#{current_dir} && sudo mongrel_rails cluster::restart")
  end
end

namespace :nginx do
  desc "Reload Nginx"
  task :reload do
    sudo "/etc/init.d/nginx reload"
  end
end
