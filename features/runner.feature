Feature: runner

  Runner.

  Scenario: Execute runner on a spec
    Given a directory named "rspec_project"
    When I cd to "rspec_project"
    Given a file named "sample_spec.rb" with:
    """
      puts "ran this spec" 
    """
    When I run "bundle exec stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "ran this spec"

  Scenario: Print docstrings
    Given a directory named "rspec_project"
    When I cd to "rspec_project"
    Given a file named "sample_spec.rb" with:
    """
      Stendhal::Example.new("my docstring") do
        puts "ran this spec" 
      end
    """
    When I run "bundle exec stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "* my docstring"
    And the output should contain "ran this spec"
