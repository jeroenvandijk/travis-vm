require 'spec_helper'

describe "Travis VM" do
  
  context "restrictions" do
    it "should not allow to connect with the internet" do
      lambda {
        require 'net/http'
        Net::HTTP.get_print 'www.example.com', '/index.html'
      }.should raise_error
    end
    
    it "should not take more than X minutes to execute a test suite"
    it "should not be allowed to do anything outside of the users home dir"
  end

  context "runner's workspace" do
    it "should be restored after use" do
      pending
      # Create files
      # Run clean up
      # Files should not exist anymore
    end
    
    it "should contain rvm directory" do
      pending
    end
  end
  
  context "runner's processes" do
    it "should be cleaned up after a build" do
      pending
      # Create processes
      # Run clean up
      # Processes should not exist anymore
    end
    it "should not have access to resources outside of the home dir" do
      lambda { Dir.chdir("/home/vagrant") }.should raise_error LoadError
    end
  end
  
  context "services" do
    it "should enable those that are stated in travis.yml"
    it "should clean those that were stated in travis.yml"
  end
  
end