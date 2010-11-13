#stendhal

A small test framework developed as a personal kata to improve my ruby.

Tested with Ruby 1.8.7, 1.9.2, JRuby 1.5.3 and Rubinius 1.1.

Currently under development, there is only basic functionality for now.
Below I will be posting whatever features are available throughout the
development.

##Current features

* Pretty decent reporter with colors
* Test doubles and stubs (also partial stubbing!)
* Mocks (message expectations) with _optionally_ stubbable return values
* Nested example groups (declare them with either describe or context)
* Pending examples
* Matchers (use with object.must or object.must_not)

    eq() / eql()

    be_a() / be_kind_of() / be_a_kind_of()

    be_whatever # asks object.whatever?


##Installation

    gem install stendhal

##Usage

    # your spec file for some class - foo_spec.rb

    describe "Foo" do

      it "does something" do
        my_object = MyClass.new
        my_object.must be_a(MyClass) 
      end

      
      it "fails when 7 is not 9" do
        (3 + 4).must eq(9)
      end

      it "asks for a kind of object" do
        "string".must be_a(String)
      end

      it "asks things to objects" do
        "string".must be_frozen
      end

      it "has common sense" do
        "string".must_not eq(3)
      end

      describe "Pending examples" do

        it "should do something but I don't know what yet"

        pending "will do something else" do
          my_object = MyClass.new
          my_object.future_method
        end

        context "under some unknown circumstances" do
          it "may act differently" do
            MyClass.must be_a(Class)
          end
        end

      end

      describe "Test double" do
        it "is declared with fake" do
          my_logger = fake('logger')
        end

        it "is declared with double as well" do
          my_logger = double('logger')
        end

        it "can be given stubs" do
          my_logger = double('logger', :my_method => 6)
          my_logger.my_method.must eq(6)
        end
      end

      describe "Partial stubbing" do
        it "returns nil by default" do
          string = "my string"
          string.stubs(:some_method)

          string.some_method # => nil
        end

        it "returns a value if you tell it to" do
          string = "my string"
          string.stubs(:some_method) { 'some value' }

          string.some_method # => "some value"
        end
      end

      describe "Message expectation" do
        it "is declared with expects" do
          string = "my string"
          string.expects(:reverse)

          string.reverse # Expectation fulfilled!
        end

        it "can be told the number of times it is expected" do
          string = "my string"
          string.expects(:reverse).once # or
          string.expects(:reverse).twice # or
          string.expects(:reverse).exactly(3).times

          string.reverse # Fails!
        end

        it "can return a stubbed value" do
          string = "my string"
          string.expects(:reverse).and_returns 'stubbed value'

          string.reverse # => "stubbed value"
        end

        it "can return a stubbed proc" do
          string = "my string"
          string.expects(:reverse).and_returns do
            3 + 4
          end

          string.reverse # => 7
        end

        it "is declared with does_not_expect in case it is negative" do
          string = "my string"
          string.does_not_expect(:reverse)

          string.reverse # Fails!
        end
      end

    end

###Running the specs!

    stendhal foo_spec.rb

###And the nice colored output...

    Foo
      * does something
      * fails when 7 is not 9 [FAILED]
        expected 7 to equal 9
      * asks for a kind of object
      * asks things to objects [FAILED]
        expected "string" to be frozen
      * has common sense

    Pending examples
      * should do something but I don't know what yet
      * will do something else
      under some unknown circumstances
        * may act differently

    Test double
      * is declared with fake
      * is declared with double as well
      * can be given stubs
    
    Partial stubbing
      * returns nil by default
      * returns a value if you tell it to

    Message expectation
      * is declared with expects
      * can be told the number of times it is expected [FAILED]
      * can return a stubbed value
      * can return a stubbed proc
      * is declared with does_not_expect in case it is negative [FAILED]

    18 examples, 4 failures, 2 pending

##Feedback

Reporting issues, asking for new features and constructive criticizing can be
done either through Github issues, the mailing list
(http://librelist.com/browser/stendhal/) or you can always reach me on twitter
(I am @txustice). Don't hesitate to tell me anything! :)

##Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add specs for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  If you want to have your own version, that is fine but bump version
  in a commit by itself I can ignore when I pull.
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Josep M. Bach. See LICENSE for details.
