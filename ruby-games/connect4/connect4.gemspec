Gem::Specification.new do |s|
    s.name                  = "connect4"
    s.summary               = "Simple Connect 4 game in the terminal"
    s.description           = "Play Connect 4 in the terminal with simple commands"
    s.version               = "0.1.0"
    s.author                = "Fanny Cheung"
    s.email                 = "fanny@ynote.hk"
    s.platform              = Gem::Platform::RUBY
    s.required_ruby_version = '>=1.9'
    s.files                 = Dir['lib/**/*.rb'] + Dir['bin/*']
    s.executables           = ['connect4']
    s.license               = 'MIT'
end
