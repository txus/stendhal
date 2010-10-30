Feature: Expectations

  Stendhal comes with some built-in expectations.

  Scenario: equality expectations
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do

          (3 + 4).should == 7
          6.should_not == 7

        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"

  Scenario: identity expectations
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do

          6.should be_a(Fixnum)

        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"

  Scenario: predicate expectations
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do

          str = "String".freeze
          str.should be_frozen

        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"
