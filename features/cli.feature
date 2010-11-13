Feature: Command line interpreter

  Stendhal runs by default all *_spec.rb files inside a spec/ folder,
  unless you specify which specs have to be runned.

  Scenario: with no arguments
    Given a directory named "stendhal_project"
    And I cd to "stendhal_project"
    And a directory named "spec"
    And a directory named "spec/nested"
    Given a file named "spec/sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do
          # put your code here 
        end
      end
    """
    And a file named "spec/another_sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do
          # put your code here 
        end
      end
      """
    And a file named "spec/nested/a_nested_spec.rb" with:
    """
      describe "something" do
        it "does something" do
          # put your code here 
        end
      end
    """
    When I run "stendhal"
    Then the exit status should be 0
    And the output should contain "3 examples, 0 failures"
