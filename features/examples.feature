Feature: Examples and example groups

  Spec-ish Domain Specific Language

  Scenario: declare an example
    Given a directory named "rspec_project"
    When I cd to "rspec_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do
          assert true
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"

  Scenario: declare a failing example
    Given a directory named "rspec_project"
    When I cd to "rspec_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do
          assert false
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "* does something"
    And the output should contain "1 example, 1 failure"

  Scenario: declare a pending example
    Given a directory named "rspec_project"
    When I cd to "rspec_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        pending "does something" do
          assert false
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "* does something"
    And the output should contain "1 example, 0 failures, 1 pending"

  Scenario: declare an example in nested groups
    Given a directory named "rspec_project"
    When I cd to "rspec_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        describe "inside another thing" do
          it "does this" do
            assert true
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
    Given a directory named "rspec_project"
    When I cd to "rspec_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        describe "inside another thing" do
          it "does this" do
            assert true
          end
        end
        describe "pending" do
          pending "todo" do
            assert false
          end
          it "fails" do
            assert false
          end
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "something"
    And the output should contain "inside another thing"
    And the output should contain "* does this"
    And the output should contain "pending"
    And the output should contain "* todo"
    And the output should contain "* fails"
    And the output should contain "3 examples, 1 failure, 1 pending"
