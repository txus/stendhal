Feature: Command line runner

  Command line runner to run spec files.

  Scenario: Runs the spec and prints docstrings
    Given a directory named "rspec_project"
    When I cd to "rspec_project"
    Given a file named "sample_spec.rb" with:
    """
      it "does something" do
        puts "indeed"
      end
    """
    When I run "bundle exec stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "* does something"
    And the output should contain "indeed"
