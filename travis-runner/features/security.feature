Feature: Secure environment
  In order to allow builds for everyone
  As a service provider
  I want to prevent safety exploits
  
  Scenario: Protect .rvm directory
    Given a file named ".travis.yml" with:
      """
      script: rm -rf *
      """
    When I run "runner build"
    Then the following directories should exist:
      | /home/runner/.rvm |
    And the following files should exist:
      | /home/runner/.bash_profile |

  Scenario: Protect all root directories
    Given a file named ".travis.yml" with:
      """
      script: cd /; rm -rf *
      """
    When I run "runner build"
    Then the following directories should exist:
      | /home/runner/  |
      | /home/vagrant/ |
  

    
  
