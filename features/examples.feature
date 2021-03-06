Feature: Examples and example groups

  RSpec-ish Domain Specific Language

  Scenario: declare an example
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do
          # put your code here 
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"

  Scenario: declare a failing example
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do
          fail "this is not what I expected"
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "* does something [FAILED]"
    And the output should contain "this is not what I expected"
    And the output should contain "1 example, 1 failure"

  Scenario: declare a pending example
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        pending "does something" do
          fail "this is not what I expected"
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "* does something"
    And the output should contain "1 example, 0 failures, 1 pending"

  Scenario: declare an example in nested groups
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        describe "inside another thing" do
          it "does this" do
            # put your code here
          end
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "something"
    And the output should contain "inside another thing"
    And the output should contain "* does this"
    And the output should contain "1 example, 0 failures"

  Scenario: many examples in different example groups
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        describe "inside another thing" do
          it "does this" do
            # put your code here
          end
          context "under certain circumstances" do
            it "does that" do
              # put your code here
            end
          end
        end
        describe "pending" do
          pending "todo" do
            # put your code here
          end
          it "fails" do
            fail "indeed"
          end
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "something"
    And the output should contain "inside another thing"
    And the output should contain "* does this"
    And the output should contain "under certain circumstances"
    And the output should contain "* does that"
    And the output should contain "pending"
    And the output should contain "* todo"
    And the output should contain "* fails [FAILED]"
    And the output should contain "indeed"
    And the output should contain "4 examples, 1 failure, 1 pending"
