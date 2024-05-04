# frozen_string_literal: true

require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

set :application_name, 'digital_portfolio'
set :domain, '37.230.113.230'
set :user, 'deploy'
set :deploy_to, '/var/www/digital'
set :repository, 'git@github.com:kkrasilov/digital_portfolio.git'
set :branch, 'develop'
set :assets_prefix, 'vite'
set :shared_files, fetch(:shared_files, []).push(
  'config/database.yml',
  'config/credentials.yml.enc',
  'config/master.key'
)

task :remote_environment do
  invoke :'rbenv:load'
  invoke :'nvm:load'
end

task :setup do
  invoke :'nvm'
end

desc 'Deploys the current version to the server.'
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle'
    invoke :'nvm:install'
    invoke :'rails:db_migrate'
    command %(yarn)
    command %(bin/vite clobber)
    command %(bin/vite build)
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %(mkdir -p tmp/)
        command %(touch tmp/restart.txt)
      end
    end
  end
end

task :nvm do
  command 'echo "-----> Installing Node Version Manager"'
  command 'curl -s https://raw.github.com/creationix/nvm/master/install.sh | sh'
  invoke :'nvm:load'
end

task :bundle do
  command 'RAILS_ENV=production bundle install --without development test'
end

namespace :nvm do
  task :load do
    command 'echo "-----> Loading nvm"'
    command %{
      source ~/.nvm/nvm.sh
    }
    command 'echo "-----> Now using nvm v.`nvm --version`"'
  end

  task :install do
    command %{
      echo "-----> Install node v.#{'18.14.0'}"
      nvm install #{'18.14.0'}
      ln -s ${NVM_BIN} ./.bin
    }
  end
end
