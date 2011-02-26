require_recipe "apt"
require_recipe "git"
require_recipe "build-essential"
require_recipe "zlib"
require_recipe "curl"

require_recipe "rails_test_databases"

require_recipe "rvm"

node[:rubies].each do |version|
  rvm_install version
end

rvm_default node[:rubies].first
