#
# Be sure to run `pod lib lint Mocky.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyMocky'
  s.version          = '1.0.41'
  s.summary          = 'Unit testing library for Swift, with mock generation. Adds a set of handy methods, simplifying testing.'
  s.description      = <<-DESC
Library that uses metaprogramming technique to generate mocks based on sources, that makes testing for Swift Mockito-like.
                       DESC

  s.homepage         = 'https://github.com/MakeAWishFoundation/SwiftyMocky'
  s.screenshots      = 'https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/1.0.0/icon.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Przemysław Wośko' => 'przemyslaw.wosko@intive.com', 'Andrzej Michnia' => 'amichnia@gmail.com' }
  s.source           = { :git => 'https://github.com/MakeAWishFoundation/SwiftyMocky.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.macos.deployment_target = '10.9'
  s.default_subspec  = "Core"
  s.preserve_paths = '*'

  s.subspec 'Core' do |core|
      core.source_files = 'Sources/Classes/**/*'
      core.resources = '{Sources/Templates/*,get_sourcery.sh}'
      core.xcconfig = { 'OTHER_SWIFT_FLAGS' => '-DMocky' }
      core.frameworks = 'Foundation'
      core.dependency 'Sourcery'
  end

  s.subspec 'InApp' do |inapp|
      inapp.source_files = 'Sources/Classes/**/*'
      inapp.resources = '{Sources/Templates/*,get_sourcery.sh}'
      inapp.xcconfig = { 'OTHER_SWIFT_FLAGS' => '-DMockyInApp' }
      inapp.frameworks = 'Foundation'
      inapp.dependency 'Sourcery'
  end
end
