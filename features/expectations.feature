Feature: Expectations

  Stendhal comes with some built-in expectations.

  Scenario: equality expectations
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do

          (3 + 4).must eq(7)
          6.must_not eql(7)

        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"

  Scenario: failed equality expectations
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do

          (3 + 4).must eql(4)

        end
        it "does something else" do

          4.must_not eq(4)

        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "expected 7 to equal 4"
    And the output should contain "expected 4 to be different than 4"
    And the output should contain "2 examples, 2 failures"

  Scenario: kind_of expectations
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do

          6.must be_a(Fixnum)
          6.must be_kind_of(Fixnum)
          6.must be_kind_of(Fixnum)

        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"

  Scenario: failed kind_of expectations
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do

          6.must_not be_a(Fixnum)

        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "expected 6 not to be a Fixnum"
    And the output should contain "1 example, 1 failure"

  Scenario: predicate expectations
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do

          str = "String".freeze
          str.must be_frozen

        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"

  Scenario: failed predicate expectations
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      describe "something" do
        it "does something" do

          hash = {:number => 3}.freeze
          hash.must_not be_frozen

        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "expected {:number=>3} not to be frozen"
    And the output should contain "1 example, 1 failure"
