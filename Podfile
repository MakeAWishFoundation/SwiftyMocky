use_frameworks!

target 'Mocky_Example' do
  platform :ios, '8.3'
  pod 'RxSwift'
  target 'Mocky_Tests' do
    inherit! :search_paths
  	pod 'SwiftyMocky', :path => './'
    pod 'RxBlocking'
  end
end

target 'Mocky_Example_tvOS' do
  platform :tvos, '9.0'
  pod 'RxSwift'
  target 'Mocky_tvOS_Tests' do
    inherit! :search_paths
    pod 'SwiftyMocky', :path => './'
    pod 'RxBlocking'
  end
end
