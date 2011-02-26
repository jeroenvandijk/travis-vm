class TravisRunner < Thor::Group
  USER = "travis_runner"
  USER_HOME = "/home/#{USER}"
  BACKUP_HOME_DIR = "/home/vagrant/travis_runner.bak"

  def run
    clean_up_runner_dir
    clean_up_runner_dir
    # su travis_runner -c "source build_file"

  end
  
  private
  
    def clean_up_runner_dir
      FileUtils.rm_r USER_HOME
      FileUtils.cp_r "#{BACKUP_HOME_DIR}/.", BACKUP_HOME_DIR
      FileUtils.chown_R USER, USER, USER_HOME
    end
end