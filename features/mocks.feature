Feature: Mocks (message expectations)

  With mocks you can check whether objects receive certain messages.

  Scenario: declare a message expectation
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      class MyClass

        def foo
        end

        def bar
          foo
        end

      end

      describe "bar" do
        it "calls foo" do
          object = MyClass.new
          object.expects(:foo)

          object.bar
        end
        it "never calls foo" do
          object = MyClass.new
          object.expects(:foo)
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "2 examples, 1 failure"
    And the output should contain "expected to be sent :foo 1 time, but received it 0 times"

  Scenario: declare a negative message expectation
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      class MyClass

        def foo
        end

        def bar
          foo
        end

      end

      describe "bar" do
        it "calls foo" do
          object = MyClass.new
          object.does_not_expect(:foo)

          object.bar
        end
        it "never calls foo" do
          object = MyClass.new
          object.does_not_expect(:foo)
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "2 examples, 1 failure"
    And the output should contain "expected to be sent :foo 0 times, but received it 1 time"
