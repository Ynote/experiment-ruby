require_relative 'options'
require_relative 'output'
require_relative 'colors'

module Webcolors
    class Runner

        def initialize(argv)
            @options = Options.new(argv)
        end

        def run
            Output.puts_notif 'Creating your file...'
            
            extension = @options.extension || 'css'
            filename = @options.output + '.' + extension || 'new_webcolors.' + extension

            if File.exist?(filename)
                Output.puts_question 'The ' + filename + ' file already exists. Do you want to continue? [Y/n]'
                answer = $stdin.gets.chomp
                if answer == 'n' || answer == 'N'
                    Output.puts_error 'New webcolors stylesheet creation aborted!'
                end
            end

                    file_content = '/* Webcolors */
'
            case extension
                when 'css'
                    DEFAULT.each do |color|
                        file_content += '
.' + color + '{background-color: \'' + color + '\';}'
                    end

                when 'scss'
                    file_content = '$colors:('
                    DEFAULT.each_with_index do |color, index|
                        color_end =  index == DEFAULT.size - 1 ? '' : ','
                        file_content += color + color_end
                    end
                    file_content += ');
                    
@each $color in $colors
{
  .#{$color}{ background-color: $color; }
}'
                else
                    Output.puts_error 'Incorrect file extension!'
                    return
            end

            f = File.new(filename, 'w')
            f.write file_content
        end

    end
end
