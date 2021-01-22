Pod::Spec.new do |s|
  s.name             = 'SwiftyPrototype'
  s.version          = '4.0.3'
  s.summary          = 'Prototyping/Faking library for Swift, with code generation. Auto-generates fakes/prototypes based on protocol definitions.'
  s.description      = <<-DESC
Library that uses metaprogramming technique to generate fakes/prototypes based on sources, makin it easier to prototype app.
                       DESC

  s.homepage         = 'https://github.com/MakeAWishFoundation/SwiftyMocky'
  s.screenshots      = 'https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/1.0.0/icon.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Przemysław Wośko' => 'przemyslaw.wosko@intive.com', 'Andrzej Michnia' => 'amichnia@gmail.com' }
  s.source           = { :git => 'https://github.com/MakeAWishFoundation/SwiftyMocky.git', :tag => s.version.to_s }

  s.swift_versions    = ['4.1', '4.2', '5.0', '5.1.2']
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.macos.deployment_target = '10.10'
  s.preserve_paths = '*'

  s.source_files = 'Sources/SwiftyPrototype/**/*.swift'
  s.resources = '{Sources/SwiftyPrototype/Prototype.swifttemplate,get_sourcery.sh}'
  s.frameworks = 'Foundation'
  s.dependency 'Sourcery', '>= 1.0.2'
end
