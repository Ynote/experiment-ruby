Gem::Specification.new do |s|
    s.name                  = "subslider"
    s.summary               = "Shift your .str subtitles easily with Subslider"
    s.description           = "Subslider is a ruby script that enables you to shift subtitles in .str format"
    s.version               = "0.1.0"
    s.author                = "Fanny Cheung"
    s.email                 = "fanny@ynote.hk"
    s.platform              = Gem::Platform::RUBY
    s.required_ruby_version = '>=1.9'
    s.files                 = Dir['lib/**/*.rb'] + Dir['bin/*']
    s.executables           = ['subslider']
    s.license               = 'MIT'
end
