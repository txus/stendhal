#!/usr/bin/env ruby

require 'stendhal'
require 'rake'
require 'rake/tasklib'

module Stendhal
  # Mostly taken from rspec-core Rake task
  class RakeTask < ::Rake::TaskLib

    # Name of task.
    #
    # default:
    #   :spec
    attr_accessor :name

    # By default, if there is a Gemfile, the generated command will include
    # 'bundle exec'. Set this to true to ignore the presence of a Gemfile, and
    # not add 'bundle exec' to the command.
    #
    # default:
    #   false
    attr_accessor :skip_bundler

    # Name of Gemfile to use
    #
    # default:
    #   Gemfile
    attr_accessor :gemfile

    # Whether or not to fail Rake when an error occurs (typically when examples fail).
    #
    # default:
    #   true
    attr_accessor :fail_on_error

    # A message to print to stderr when there are failures.
    attr_accessor :failure_message

    # Use verbose output. If this is set to true, the task will print the
    # executed spec command to stdout.
    #
    # default:
    #   true
    attr_accessor :verbose

    # Command line options to pass to ruby.
    #
    # default:
    #   nil
    attr_accessor :ruby_opts

    # Path to stendhal
    #
    # default:
    #   'stendhal'
    attr_accessor :stendhal_path

    def initialize(*args)
      @name = args.shift || :spec
      @ruby_opts = nil
      @skip_bundler = false
      @verbose, @fail_on_error = true, true
      @gemfile = 'Gemfile'

      yield self if block_given?

      @stendhal_path ||= 'stendhal'

      desc("Run Stendhal code examples") unless ::Rake.application.last_comment

      task name do
        RakeFileUtils.send(:verbose, verbose) do
          begin
            ruby(stendhal_command)
          rescue
            puts failure_message if failure_message
            raise("ruby #{stendhal_command} failed") if fail_on_error
          end
        end
      end
    end

  private

    def stendhal_command
      @stendhal_command ||= begin
                          cmd_parts = [ruby_opts]
                          cmd_parts << "-S"
                          cmd_parts << "bundle exec" if gemfile? unless skip_bundler
                          cmd_parts << stendhal_path
                          cmd_parts.flatten.compact.reject(&blank).join(" ")
                        end
    end

  private

    def blank
      lambda {|s| s == ""}
    end

    def gemfile?
      File.exist?(gemfile)
    end

  end
end
