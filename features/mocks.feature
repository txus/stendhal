Feature: Mocks (message expectations)

  With mocks you can check whether objects receive certain messages.

  Scenario: declare a message expectation
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      class MyClass

        def foo
          'called foo' 
        end

        def bar
          foo
        end

      end

      describe "bar" do
        it "calls foo" do
          object = MyClass.new
          object.expects(:foo) # Defaults to .once

          object.bar.must eq('called foo') # The return value is not stubbed
        end
        it "calls foo two times" do
          object = MyClass.new
          object.expects(:foo)
          object.expects(:foo) # This makes two calls expected

          2.times { object.bar } 
        end
        it "never calls foo" do
          object = MyClass.new
          object.expects(:foo)
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "3 examples, 1 failure"
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

  Scenario: declare a message expectation with a number of times
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
        it "calls foo twice" do
          object = MyClass.new
          object.expects(:foo).twice

          object.bar
          object.bar
        end
        it "calls foo three times" do
          object = MyClass.new
          object.expects(:foo).exactly(3).times

          3.times { object.bar } 
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "2 examples, 0 failures"

  Scenario: declare a message expectation stubbing the return value
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      class MyClass

        def foo
          'called foo' 
        end

        def bar
          foo
        end

      end

      describe "bar" do
        it "calls foo and returns a stubbed value" do
          object = MyClass.new
          object.expects(:foo).and_returns('stubbed foo')

          object.bar.must eq('stubbed foo')
        end
        it "calls foo three times" do
          object = MyClass.new
          object.expects(:foo).exactly(3).times.and_returns('stubbed foo')

          3.times { object.bar.must eq('stubbed foo') } 
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "2 examples, 0 failures"
