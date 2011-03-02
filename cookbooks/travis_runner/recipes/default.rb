require_recipe "rails_test_databases"

require_recipe "rvm"

node[:rubies].each do |version|
  rvm_install version
end

rvm_default node[:rubies].first

execute "gem install bundler" do
  user "vagrant"
  cwd "home/vagrant"
  not_if "gem list | bundler"
end

execute "bundle install" do
  user "vagrant"
  cwd "/home/vagrant/travis-vm/travis-runner"
  not_if "bundle check"
end



travis_runner = "runner"

execute "Add the worker to the runner group" do
  command "usermod -a -G #{travis_runner} vagrant"
  not_if "grep #{travis_runner} /etc/group | grep vagrant"
end

user travis_runner do
  shell "/bin/bash"
  home "/home/#{travis_runner}"
end

# Easy interface for determining permissions code
# http://service.futurequest.net/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=27

# Make the runners home dir readable and executable by the group, but not writable (only the workspace) 
directory "/home/#{travis_runner}" do
  owner travis_runner
  group travis_runner
  mode "550"
  action :create
end

# Copy the home directory so the runner will also have RVM installed
execute "cp -r /home/vagrant/.rvm /home/#{travis_runner}/.rvm" do
  not_if { File.exists?("/home/#{travis_runner}/.rvm") }
end

execute "chown -R #{travis_runner}:#{travis_runner} /home/#{travis_runner}/.rvm"
# Only allow read and execution of the .rvm files, no changes
execute "chmod -R 500 /home/#{travis_runner}/.rvm"

# Let them do anything they want with the workspace (we will create it every time again)
directory "/home/#{travis_runner}/workspace" do
  owner travis_runner
  group travis_runner
  mode "770"
  action :create
end

execute "cp /home/vagrant/.bash_profile /home/#{travis_runner}/.bash_profile" do
  not_if { File.exists?("/home/#{travis_runner}/.bash_profile") }
end

# Make the following files readable and executable for both the owner and the group
# .bashrc 
%w(.bash_profile).each do |file|
  execute "chown #{travis_runner}:#{travis_runner} /home/#{travis_runner}/#{file}"
  execute "chmod 550 /home/#{travis_runner}/#{file}"
end

## Network safety

# Add to put the following line under auto wlan0 or auto eth0 in /etc/network/interfaces
#     
#     pre-up iptables -A OUTPUT -p tcp -m owner --uid-owner username -j DROP
# 
# run command:
# 
#     sudo iptables -A OUTPUT -p tcp -m owner --uid-owner username -j DROP
