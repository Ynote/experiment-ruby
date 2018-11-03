Gem::Specification.new do |s|
    s.name                  = "tictactoe"
    s.summary               = "Simple Tic-Tac-Toe game in the terminal"
    s.description           = "Play Tic-Tac-Toe in the terminal with simple commands"
    s.version               = "0.1.1"
    s.author                = "Fanny Cheung"
    s.email                 = "fanny@ynote.hk"
    s.platform              = Gem::Platform::RUBY
    s.required_ruby_version = '>=1.9'
    s.files                 = Dir['lib/**/*.rb'] + Dir['bin/*']
    s.executables           = ['tictactoe']
    s.license               = 'MIT'
end
