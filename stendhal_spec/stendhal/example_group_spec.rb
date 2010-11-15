module Stendhal
  describe ExampleGroup do

    # before(:each) do
    #   ExampleGroup.destroy_all
    #   Example.destroy_all
    # end

    it "is created with a docstring and a block" do
      group = ExampleGroup.new("docstring") do
        
      end
      group.description.must eq("docstring")
    end

    it "allows example declaration inside the block" do
      lambda {
        ExampleGroup.new("docstring") do
          it "does something" do
          end
        end
      }.must_not raise_error
    end

    describe "#add_example" do
      it 'adds an example to the group' do
        ExampleGroup.destroy_all
        Example.destroy_all

        group = ExampleGroup.new("docstring") 
        group.add_example Example.new("docstring")
        # group.should have(1).examples
        group.examples.length.must eq(1)
      end
    end

    describe "#run" do
      # before(:each) do
      #   @runnable_examples = []
      #   @group = ExampleGroup.new("group")
      #   4.times do
      #     example = Example.new("some example") do
      #       true
      #     end
      #     @runnable_examples << example
      #     @group.add_example example
      #   end
      #   @failing_example = Example.new("failing") do
      #     fail "this example fails just because"
      #   end
      #   @group.add_example @failing_example
      #   @pending_example = Example.new("pending")
      #   @group.add_example @pending_example
      #   @group.add_example_group("another group")
      # end

      it "runs all non-pending examples" do
        @runnable_examples = []
        @group = ExampleGroup.new("group")
        4.times do
          example = Example.new("some example") do
            true
          end
          @runnable_examples << example
          @group.add_example example
        end
        @failing_example = Example.new("failing") do
          fail "this example fails just because"
        end
        @group.add_example @failing_example
        @pending_example = Example.new("pending")
        @group.add_example @pending_example
        @group.add_example_group("another group")

        @runnable_examples.each {|e| e.expects(:run).once.and_returns(0)}
        @failing_example.expects(:run).once.and_returns(1)
        @pending_example.does_not_expect(:run)

        @group.run

        ExampleGroup.destroy_all
        Example.destroy_all
      end

      it "runs all its children" do
        @runnable_examples = []
        @group = ExampleGroup.new("group")
        4.times do
          example = Example.new("some example") do
            true
          end
          @runnable_examples << example
          @group.add_example example
        end
        @failing_example = Example.new("failing") do
          fail "this example fails just because"
        end
        @group.add_example @failing_example
        @pending_example = Example.new("pending")
        @group.add_example @pending_example
        @group.add_example_group("another group")

        @group.example_groups.each do |g|
          g.expects(:run)
        end
        @group.run

        ExampleGroup.destroy_all
        Example.destroy_all
      end

      it "returns an array with total examples, failures and pendings" do
        @runnable_examples = []
        @group = ExampleGroup.new("group")
        4.times do
          example = Example.new("some example") do
            true
          end
          @runnable_examples << example
          @group.add_example example
        end
        @failing_example = Example.new("failing") do
          fail "this example fails just because"
        end
        @group.add_example @failing_example
        @pending_example = Example.new("pending")
        @group.add_example @pending_example
        @group.add_example_group("another group")

        @group.run.must eq([6,1,1])

        ExampleGroup.destroy_all
        Example.destroy_all
      end
    end    

    describe "#add_example_group" do
      it "adds a nested example group inside self" do
        example_group = ExampleGroup.new("group")
        example_group.add_example_group(ExampleGroup.new("other group"))
        example_group.example_groups.first.has_parent?.must eq(true)

        ExampleGroup.destroy_all
        Example.destroy_all
      end
    end

    describe "class methods" do
      describe "#count" do
        it "returns the number of example groups in memory" do
          ExampleGroup.destroy_all
          Example.destroy_all

          ExampleGroup.new("group")
          ExampleGroup.count.must eq(1)

          ExampleGroup.destroy_all
          Example.destroy_all
        end
      end
      describe "#run_all" do
        it "sums all the examples, failures and pendings and returns them as an array" do
          ExampleGroup.destroy_all
          Example.destroy_all

          group1 = ExampleGroup.new("group")
          group1.stubs(:run) { [1,2,3] }
          group2 = ExampleGroup.new("group")
          group2.stubs(:run) { [1,0,1] }

          ExampleGroup.run_all.must eq([2,2,4])

          ExampleGroup.destroy_all
          Example.destroy_all
        end
      end
    end

  end
end
