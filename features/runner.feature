Feature: runner

  Runner.

  Scenario: Execute runner on a spec
    Given a directory named "rspec_project"
    When I cd to "rspec_project"
    Given a file named "sample_spec.rb" with:
    """
    describe "something" do
      it "does something" do
      end
    end
    """
    When I run "stendhal sample_spec.rb"
    Then the output should contain:
      """
      something
        does something
      """
