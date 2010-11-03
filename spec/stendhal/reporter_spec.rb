require 'spec_helper'

module Stendhal
  describe Reporter do

    let(:out) { StringIO.new }

    after(:each) do
      Reporter.reset
      out.flush
    end

    it 'is a singleton' do
      Reporter.instance.should be_a(Reporter)  
    end

    describe "instance methods" do

      before(:each) do
        Reporter.output = out
      end
    
      describe "#line" do

        it 'outputs a line' do
          Reporter.line "This is a line"
          out.string.should include("This is a line\n")
        end

        context "with indentation" do
          it 'outputs an indented line' do
            Reporter.line "This is a line", :indent => 2
            out.string.should include("  This is a line\n")
          end
        end

        context "with color" do
          it 'outputs a coloured line' do
            Reporter.line "This is a line", :color => :red
            out.string.should include("\e[0;31mThis is a line\e[0m\n")
          end
        end

      end

      describe "#whitespace" do
        it 'outputs whitespace' do
          Reporter.whitespace
          out.string.should match(/\n/)
        end
      end

      describe "#tab" do
        it 'outputs a tab' do
          Reporter.tab
          out.string.should include("  ")
        end
      end

      describe "#current_indentation" do
        it 'returns 0 by default' do
          Reporter.current_indentation.should == 0
        end
        it 'can be set' do
          Reporter.current_indentation = 2
          Reporter.current_indentation.should == 2
        end
      end
    
    end

  end
end
