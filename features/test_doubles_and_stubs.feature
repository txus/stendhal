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
        it "does something" do
          logger = double('logger')
          object = MyClass.new(logger)

          object.must be_a(MyClass)
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"

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
          @logger.log "Doing something"
          if @logger.print
            return "result"
          end
        end
      end

      describe "something" do
        it "does something" do
          logger = double('logger', :log => nil, :print => true)
          object = MyClass.new(logger)

          object.do_something.must == "result"
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"

  Scenario: partial stubbing
    Given a directory named "stendhal_project"
    When I cd to "stendhal_project"
    Given a file named "sample_spec.rb" with:
    """
      class Boss
        def do_something
          seem_busy
          delegate_stuff
        end
        def delegate_stuff
          nil  
        end
      end

      describe "my boss" do
        it "does something" do
          boss = Boss.new
          boss.stub(:seem_busy)
          boss.stub(:delegate_stuff).and_return(:done)

          boss.do_something.should eq(:done)
        end
      end
    """
    When I run "stendhal sample_spec.rb"
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"
