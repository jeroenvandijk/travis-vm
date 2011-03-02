

require 'aruba/cucumber'

module WorldExtensions

  def dirs
    @dirs ||= "/home/runner/workspace"
  end
  
end

World(WorldExtensions)