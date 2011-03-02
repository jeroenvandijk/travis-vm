# Travis-VM

This is alpha work only use when you know what you are doing :)

## Getting started

* Install Virtualbox v4
* Clone this directory
* Run the following commands
    
    gem install vagrant
    vagrant up
    
    # wait a bit
    
    vagrant ssh
    cd travis-vm/travis-runner
    bundle exec cucumber features
  