Feature: DSL

  Spec-ish Domain Specific Language

  Scenario: declare an example
    Given a directory named "rspec_project"
    When I cd to "rspec_project"
    Given a file named "sample_spec.rb" with:
    """
      it "does something" do
        assert true
      end
    """
    When I run "bundle exec stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"

  Scenario: declare a failing example
    Given a directory named "rspec_project"
    When I cd to "rspec_project"
    Given a file named "sample_spec.rb" with:
    """
      it "does something" do
        assert false
      end
    """
    When I run "bundle exec stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "* does something"
    And the output should contain "1 example, 1 failure"

  Scenario: declare a pending example
    Given a directory named "rspec_project"
    When I cd to "rspec_project"
    Given a file named "sample_spec.rb" with:
    """
      pending "does something" do
        assert false
      end
    """
    When I run "bundle exec stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "* does something"
    And the output should contain "1 example, 0 failures, 1 pending"
