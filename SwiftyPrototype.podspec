Pod::Spec.new do |s|
  s.name             = 'SwiftyPrototype'
  s.version          = '4.0.0'
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
  s.default_subspec  = "Prototyping"
  s.preserve_paths = '*'

  s.subspec 'Testing' do |spec|
    spec.source_files = 'Sources/{Classes,Mock}/**/*'
    spec.resources = '{Sources/Mock/Mock.swifttemplate,get_sourcery.sh}'
    spec.frameworks = 'Foundation'
    spec.weak_framework = "XCTest"
    spec.dependency 'Sourcery', '>= 0.18'
    spec.pod_target_xcconfig = {
        'APPLICATION_EXTENSION_API_ONLY' => 'YES',
        'ENABLE_BITCODE' => 'NO',
        'OTHER_LDFLAGS' => '$(inherited) -weak-lswiftXCTest -Xlinker -no_application_extension',
        'OTHER_SWIFT_FLAGS' => '$(inherited) -suppress-warnings',
        'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(PLATFORM_DIR)/Developer/Library/Frameworks"',
        'DEFINES_MODULE' => 'YES'
    }
    spec.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }
  end

  s.subspec 'Prototyping' do |spec|
    spec.source_files = 'Sources/{Classes,Prototype}/**/*'
    spec.resources = '{Sources/Prototype/Prototype.swifttemplate,get_sourcery.sh}'
    spec.frameworks = 'Foundation'
    spec.dependency 'Sourcery', '>= 0.18'
  end
end
