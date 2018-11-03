require 'optparse'

module Webcolors
    class Options

        attr_reader :output, :extension

        def initialize(argv)
            parse(argv)
        end

        private

        def parse(argv)
            OptionParser.new do |opts|

                opts.banner = 'Usage: webcolors [output filename]'

                opts.on(:REQUIRED, '-o', '--output', String, 'Output filename') do |o|
                    @output = o
                end

                opts.on(:REQUIRED, '-e', '--output', String, 'Output filename') do |e|
                    @extension = e
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
