# Subslider

Subslider is a ruby script that enables you to shift subtitles. This project is in progress.
For the moment, you can just add time on your subtitles file and the only handled format is `.str`.

## Installation

    $ git clone git@github.com:Ynote/subslider.git
    $ cd subslider
    $ gem install subslider-0.1.0.gem

## Getting started

Example to add 10 seconds to your file:

    $ subslider -i [path_to_your_input_file] -a 00:00:10

## Documentation

    -v, --verbose                    Run verbosely
    -a, --add time                   Shift subtitle forward
    -r, --remove time                Shift subtitle backward
    -i, --input filename             Source filename
    -o, --output filename            Output filename
    -h, --help                       Show this message
        --version                    Show version

