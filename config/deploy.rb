set :application, "swc4"
set :repository,  "git://github.com/datenimperator/software-consultant.net.git"
set :branch, "swc2"
set :rvm_type, :system
set :rvm_ruby_string, 'ruby-1.9.3'

require 'rvm/capistrano'
require 'bundler/capistrano'

default_run_options[:pty] = true
set :use_sudo, false
ssh_options[:keys] = %w(/Users/christian/.ssh/id_dsa)
ssh_options[:auth_methods] = ['publickey']

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, 'software-consultant.net'
set :domain, 'v4.software-consultant.net'
set :deploy_to, '/home/software-consultant.net'

server domain, :app, :web
role :app, domain
role :web, domain

after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
