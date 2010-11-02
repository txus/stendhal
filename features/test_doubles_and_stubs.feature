Feature: Test doubles and stubs

  Use test doubles and stubs everywhere! They help decoupling :)

  Scenario: declare a test double
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      class MyClass
        def initialize(logger)
          @logger = logger
        end
      end

      describe "something" do
        it "declares test doubles with :fake helper" do
          logger = fake('logger')
          object = MyClass.new(logger)

          object.must be_a(MyClass)
        end
        it "declares test doubles with :double helper as well" do
          logger = double('logger')
          object = MyClass.new(logger)

          object.must be_a(MyClass)
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "2 examples, 0 failures"

  Scenario: declare a test double with stubs
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      class MyClass
        def initialize(logger)
          @logger = logger
        end
        def do_something
          @logger.log "Logger"
          if @logger.print
            return "result"
          end
        end
      end

      describe "something" do
        it "does something" do
          logger = fake('logger', :log => nil, :print => true)
          object = MyClass.new(logger)

          object.do_something.must eq("result")
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"
