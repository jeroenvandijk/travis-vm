require 'spec_helper'

describe "Travis VM" do
  
  context "restrictions" do
    it "should not allow to connect with the internet"
    it "should not take more than X minutes to execute a test suite"
    it "should not be allowed to do anything outside of the users home dir"
  end

  context "runner's workspace" do
    it "should be restored after use"
  end
  
  context "runner's processes" do
    it "should be cleaned up after a build"
    it "should not have access to resources outside of the home dir"
  end
  
  context "services" do
    it "should enable those that are stated in travis.yml"
    it "should clean those that were stated in travis.yml"
  end
  
end