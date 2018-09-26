use_frameworks!

target 'Mocky_Example_iOS' do
  platform :ios, '9.0'
  target 'Mocky_Tests_iOS' do
    inherit! :search_paths
  	pod 'SwiftyMocky', :path => './'
  end
end

target 'Mocky_Example_tvOS' do
  platform :tvos, '9.0'
  target 'Mocky_Tests_tvOS' do
    inherit! :search_paths
    pod 'SwiftyMocky', :path => './'
  end
end

target 'Mocky_Example_macOS' do
    platform :macos, '10.13'
    target 'Mocky_Tests_macOS' do
        inherit! :search_paths
        pod 'SwiftyMocky', :path => './'
    end
end

post_install do |installer|
  system("rake sourcery") # use default version from rakefile
end
