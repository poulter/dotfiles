#!/usr/bin/env ruby 

# == Synopsis 
#   This is a sample description of the application.
#   Blah blah blah.
#
# == Examples
#   This command does blah blah blah.
#     myapp foo.txt
#
#   Other examples:
#     myapp -q bar.doc
#     myapp --verbose foo.html
#
# == Usage 
#   myapp [options] source_file
#
#   For help use: myapp -h
#
# == Options
#   -h, --help          Displays help message
#   -v, --version       Display the version, then exit
#   -q, --quiet         Output as little as possible, overrides verbose
#   -V, --verbose       Verbose output
#   TODO - add additional options
#
# == Author
#   <%= `git config --get --global user.name`.chomp %>
#
# == Copyright
#   Copyright (c) 2010 <%= `git config --get --global user.name`.chomp %>.
#   

# TODO - update Synopsis, Examples, etc
# TODO - change license if necessary

require 'rubygems'
require 'trollop'
require 'ostruct'
require 'date'

class App
  VERSION = '0.0.1'
  APP = File.basename(__FILE__,".rb")
  
  attr_reader :options

  def initialize(arguments, stdin)
    @arguments = arguments
    @stdin     = stdin
    # TODO - add additional defaults
  end

  # Parse options, check arguments, then process the command
  def run
    if parsed_options? && arguments_valid? 
      puts "Start at #{DateTime.now}\n\n" if @options.verbose
      output_options if @options.verbose # [Optional]
      process_arguments            
      process_command
      puts "\nFinished at #{DateTime.now}" if @options.verbose
    else
      Trollop::die "user error, replace user and continue"
    end
  end
  
  protected
  
    def parsed_options?
      
      # Specify options
      @options = Trollop::options @arguments do
        version "#{APP} #{VERSION} (c) 2010 <%= `git config --get --global user.name`.chomp %>"
        banner <<-EOS
Test is an awesome program that does something very, very important.

Usage:
       #{__FILE__} [options] <filenames>+
where [options] are:
EOS
        opt :version , "Print version of #{APP} and exit"
        opt :help    , "Print this message and exit"
        opt :verbose , "Enable verbose mode"
        opt :quiet   , "Enable quiet mode"
        # TODO - add additional options
      end

      process_options
      true      
    end

    def arguments_valid?
      # TODO - implement your real logic here
      true if @arguments.length == 1 
    end

    def process_options
      # more debug has priority over less debug
      @options[:verbose] = true       if @options.debug
      @options[:quiet  ] = false      if @options.verbose
    end
    def process_arguments
      # TODO - place in local vars, etc
    end
    def process_command
      # TODO whatever this program does
      
      #process_standard_input # [Optional]
    end
    def process_standard_input
      input = @stdin.read      
      # TODO - process input
      
      # [Optional]
      # @stdin.each do |line| 
      #  # TODO - process each line
      #end
    end

    def error(msg)
      message "Error", msg
      raise 
    end
    def normal(msg)
      puts msg unless @options.quiet
    end
    def verbose(msg)
      puts msg if @options.verbose
    end
    def debug(msg)
      message "Debug", msg if @options.debug
    end
    def message(type,msg)
      if msg =~ /\n/
        puts "#{type}: (Multi-line) +++++++++++++++++++++++++++++++++++++++\n"
        puts "#{@doc}" if @options.quiet
        puts "#{msg}"
        puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      else
        print "#{@doc} - " if @options.quiet
        puts "#{type}: #{msg}"
      end
    end
    def output_options
      puts "Options:\n"
      
      @options.each do |name, val|        
        puts "  #{name} = #{val}"
      end
    end
end

# TODO - Add your Modules, Classes, etc

# Create and run the application
app = App.new(ARGV, STDIN)
app.run


