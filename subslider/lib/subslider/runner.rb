require_relative 'options'
require_relative 'time_shifter'
require_relative 'output'
require_relative 'split_line'

module Subslider
    class Runner

        def initialize(argv)
            @options = Options.new(argv)
        end

        def run
            if @options.input.nil?
                Output.puts_error 'No file provided. Please enter a file name'

            else
                if not File.file?(@options.input)
                    Output.puts_error 'The provided argument is not a file. Please enter a file name. [-i myfilename.srt]'

                else
                    Output.puts_notif 'Creating your file...'

                    new_filename = @options.output || File.basename(@options.input).gsub(File.extname(@options.input), '_new' + File.extname(@options.input))
                    if File.exist?(new_filename)
                        Output.puts_question 'The ' + new_filename + ' file already exists. Do you want to continue? [Y/n]'
                        answer = $stdin.gets.chomp
                        if answer == 'n' || answer == 'N'
                            Output.puts_error 'New subtitles file creation aborted!'

                        end

                    end

                    if @options.add.nil? and @options.remove.nil?
                        Output.puts_error 'The time argument is missing. Please enter a time. [-a or -r 00:00:00]!'

                    elsif not @options.add.nil? and not @options.remove.nil?
                        Output.puts_error 'You can only use -r OR -a flag. Please re-enter a time with a correct flag [-a or -r 00:00:00]!'
                    end

                    new_f = File.new(new_filename, 'w')

                    f = File.open(@options.input, 'r:utf-8')
                    f.each_with_index do |line, index|
                        split_line = SplitLine.new(line)
                        if sequence = split_line.get_time_sequence

                            begin
                                new_line = TimeShifter.new(sequence, @options)
                            rescue StandardError => error
                                if error == 'SHIFT-OPT-MISSING'
                                    Output.puts_error 'The time argument is missing. Please enter a time. [-a or -r 00:00:00]!'
                                end
                            end

                            # VERBOSE PART
                            if not @options.verbose.nil?
                                puts "=== Change line #{index.to_s} \n"
                                puts "     #{line}  >>  #{new_line.shift}\n"

                            end
                            # END VERBOSE PART

                            new_f.print new_line.shift
                            new_f.print

                        else
                            new_f.print line
                        end
                    end

                    Output.puts_notif 'Your new subtitles file is ready!'
                end
                f.close
            end
        end

    end
end


