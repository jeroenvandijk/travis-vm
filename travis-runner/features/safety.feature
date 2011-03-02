Feature: Safety

  Scenario: Running a custom build script
    Given a file named "/home/runner/build.rb" with:
      """
      puts 'test suite is passing'
      """
    And a file named ".travis.yml" with:
      """
      script: ruby build.rb
      """
    When I run "runner build"
    Then the output should contain "test suite is passing"
  

  Scenario: Make .rvm directory not removable
    Given a file named ".travis.yml" with:
      """
      script: rm -rf *
      """
    When I run "runner build"
    Then the following directories should exist:
      | /home/runner/.rvm |
    And the following files should exist:
      | /home/runner/.bashrc     |
      | /home/runner/.bash_login |

