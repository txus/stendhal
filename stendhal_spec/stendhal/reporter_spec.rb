module Stendhal
  describe Reporter do

    it 'is a singleton' do
      Reporter.instance.must be_a(Reporter)  
    end

    describe "instance methods" do
    
      describe "#line" do

        it 'outputs a line' do
          out = StringIO.new
          Reporter.output = out

          Reporter.line "This is a line"
          out.string.must include("This is a line\n")

          Reporter.reset
          out.flush
        end

        context "with indentation" do
          it 'outputs an indented line' do
            out = StringIO.new
            Reporter.output = out

            Reporter.line "This is a line", :indent => 2
            out.string.must include("  This is a line\n")

            Reporter.reset
            out.flush
          end
        end

        context "with color" do
          it 'outputs a coloured line' do
            out = StringIO.new
            Reporter.output = out

            Reporter.line "This is a line", :color => :red
            out.string.must include("\e[0;31mThis is a line\e[0m\n")

            Reporter.reset
            out.flush
          end
        end

      end

      describe "#whitespace" do
        it 'outputs whitespace' do
          out = StringIO.new
          Reporter.output = out

          Reporter.whitespace
          out.string.must include("\n")

          Reporter.reset
          out.flush
        end
      end

      describe "#tab" do
        it 'outputs a tab' do
          out = StringIO.new
          Reporter.output = out

          Reporter.tab
          out.string.must include("  ")

          Reporter.reset
          out.flush
        end
      end

      describe "#current_indentation" do
        it 'returns 0 by default' do
          Reporter.current_indentation.must eq(5)
        end
        it 'can be set' do
          original_indentation = Reporter.current_indentation
          Reporter.current_indentation = 2
          Reporter.current_indentation.must eq(2)
          Reporter.current_indentation = original_indentation
        end
      end
    
    end

  end
end
