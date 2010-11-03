Feature: Reporter

  Stendhal reports examples in a decent visual manner.

  Scenario: simple colored report
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do
          false.must eq(false)
        end
      end

      describe "other thing" do
        describe "under other circumstances" do
          it "fails" do
            true.must_not eq(true)
          end
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "37msomething"
    And the output should contain "32m* does something"
    And the output should contain "37mother thing"
    And the output should contain "37munder other circumstances"
    And the output should contain "31m* fails"
    And the output should contain "31m2 examples, 1 failure"
