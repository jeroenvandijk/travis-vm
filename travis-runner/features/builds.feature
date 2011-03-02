Feature: Building repos
  In order to have high code quality for open source projects
  As a CI service provider
  I want to run test suites for many projects

Scenario: Running a custom build script
  Given a file named "/home/runner/workspace/build.rb" with:
    """
    puts 'test suite is passing'
    """
  And a file named ".travis.yml" with:
    """
    script: ruby build.rb
    """
  When I run "runner build"
  Then the output should contain "test suite is passing"