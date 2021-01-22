Pod::Spec.new do |s|
  s.name             = 'SwiftyMocky'
  s.version          = '4.0.3'
  s.summary          = 'Unit testing library for Swift, with mock generation. Adds a set of handy methods, simplifying testing.'
  s.description      = <<-DESC
Library that uses metaprogramming technique to generate mocks based on sources, that makes testing for Swift Mockito-like.
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

  s.source_files = 'Sources/SwiftyMocky/**/*.swift'
  s.resources = '{Sources/SwiftyMocky/Mock.swifttemplate,get_sourcery.sh}'
  s.frameworks = 'Foundation'
  s.weak_framework = "XCTest"
  s.dependency 'Sourcery', '>= 1.0.2'
  s.pod_target_xcconfig = {
      'APPLICATION_EXTENSION_API_ONLY' => 'YES',
      'ENABLE_BITCODE' => 'NO',
      'OTHER_LDFLAGS' => '$(inherited) -weak-lswiftXCTest -Xlinker -no_application_extension',
      'OTHER_SWIFT_FLAGS' => '$(inherited) -suppress-warnings',
      'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(PLATFORM_DIR)/Developer/Library/Frameworks"',
      'DEFINES_MODULE' => 'YES'
  }
  s.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }
end
