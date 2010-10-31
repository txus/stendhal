#stendhal

A small test framework developed as a personal kata to improve my ruby.

Currently under development, there is only basic functionality for now.
Below I will be posting whatever features are available throughout the
development.

##Current features

* Nested example groups
* Pending examples
* Lame reporter (but will get better eventually)
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

      end

    end

###Running the specs!

    stendhal foo_spec.rb

###And the output...

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

    7 examples, 2 failures, 2 pending

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
