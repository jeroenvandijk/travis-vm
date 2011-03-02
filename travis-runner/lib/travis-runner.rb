require 'thor'
require 'rspec-expectations'
require 'open3'

module Travis
  module Runner
    class Base < Thor
      USER = "runner"
      USER_HOME = "/home/#{USER}"
      USER_WORKSPACE = "#{USER_HOME}/workspace"

      desc "hjhkhkj", "kjhkh"
      def safety_check
        # "test".should == "test1"
      end

      desc "Builsad", "sadfkasd"
      def build
        travis_config_file = File.join(USER_WORKSPACE, ".travis.yml")

        if File.exist?(travis_config_file)
          configuration = YAML.load_file(travis_config_file)
          build_command = configuration["script"]
        end
        
        build_command ||= "rake"
        # files = Dir.glob("#{USER_HOME}/*", File::FNM_DOTMATCH).reject { |p| p =~ %r{#{USER_HOME}/\.+$} }
        # FileUtils.rm_r(files, :force => true, :secure => true)

        bash = <<-BASH
          cd #{USER_WORKSPACE}
          #{build_command}
          exit
        BASH
        
        
        Open3.popen3("sudo su #{USER} -c '#{bash}'") do |stdin, out, err, external| 
          while line = err.gets || out.gets do
            print line
          end
        end
        # clean_up_runner_dir
        # clean_up_runner_dir
        # # su travis_runner -c "source build_file"
        # sudo su runner bash -c "cd ;pwd; source ~/.bash_profile; which ruby"
      end
  
      private
  
        def clean_up_runner_dir
          FileUtils.rm_r USER_HOME
        end

    end
  end
end