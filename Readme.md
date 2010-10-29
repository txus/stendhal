#stendhal

A small test framework developed as a personal kata to improve my ruby.

Currently under development, there is only basic functionality for now.
Below I will be posting whatever features are available throughout the
development.

##Installation

    gem install stendhal

##Usage

    # your spec file for some class - my_class_spec.rb

    describe "My fancy class" do

      it "does something" do
        my_object = MyClass.new
        my_object.fancy = true

        assert my_object.fancy
      end

      describe "Additional functionality" do

        it "should do something but I don't know what yet"

        pending "will do something else" do
          my_object = MyClass.new
          my_object.future_method
        end

      end

    end

###Running the specs!

    stendhal my_class_spec.rb

###And the output...

    My fancy class
    * does something

    Additional functionality
    * should do something but I don't know what yet
    * will do something else

    3 examples, 0 failures, 2 pending

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
