Vagrant::Config.run do |config|
  config.vm.box = "lucid64"
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"

  config.vm.customize do |vm|
    vm.name = "Travis Virtual Machine"
    vm.memory_size = 1024
  end
  
  config.vm.share_folder('travis-runner', 'travis-vm', '.')
  
  config.vm.forward_port("ssh", 22, 1234)
  
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "vagrant_main"
    
    chef.cookbooks_path = "cookbooks"
    
    chef.json.merge!({
      :rubies => %w( 1.8.7),# ree  ruby-head  rbx-head  jruby  ironruby  maglev-head ),
      :mysql => { 
        :server_root_password => "root"
      },
      :memcached => { 
        :ipaddress => "127.0.0.1"
      }    
    })
  
    chef.log_level = :debug
  end
  
  
end
