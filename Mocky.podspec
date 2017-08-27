#
# Be sure to run `pod lib lint Mocky.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Mocky'
  s.version          = '0.0.2'
  s.summary          = 'Unit testing library for Swift'
  s.description      = <<-DESC
Library that uses metaprogramming technique, to generate mocks based on sources, that makes testing for Swift Mockito-like.
                       DESC

  s.homepage         = 'https://github.com/CurlyHeir/Mocky'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Przemysław Wośko' => 'przemyslaw.wosko@intive.com' }
  s.source           = { :git => 'https://github.com/CurlyHeir/Mocky.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Mocky/Classes/**/*'
  s.preserve_paths = '*'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'XCTest'
  s.dependency 'Sourcery'
end
