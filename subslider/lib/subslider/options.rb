require 'optparse'

module Subslider
    class Options

        attr_reader :verbose, :add, :remove, :input, :output

        def initialize(argv)
            parse(argv)
        end

        private

        def parse(argv)
            OptionParser.new do |opts|

                opts.banner = "Usage: subslider.rb [flags] [time] [subtitles_file] [new filename]"

                opts.on("-v", "--verbose", "Run verbosely") do |v|
                    @verbose = v
                end

                opts.on("-a", "--add time", String, "Shift subtitle forward") do |a|
                    @add = a
                end

                opts.on("-r", "--remove time", String, "Shift subtitle backward") do |r|
                    @remove = r
                end

                opts.on("-i", "--input filename", String, "Source filename") do |i|
                    @input = i
                end

                opts.on("-o", "--output filename", String, "Output filename") do |o|
                    @output = o
                end

                opts.on_tail("-h", "--help", "Show this message") do
                    puts opts
                    exit
                end

                opts.on_tail("--version", "Show version") do
                    puts ::Version.join('.')
                    exit
                end

                begin
                    argv = ['-h'] if argv.empty?
                    opts.parse!(argv)
                rescue OptionParser::ParseError => e
                    STDERR.puts e.message, "\n", opts
                    exit(-1)
                end

            end
        end

    end
end
