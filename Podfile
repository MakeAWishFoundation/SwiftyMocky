use_frameworks!

def tests
    pod 'SwiftyMocky', :path => './'
end

target 'Mocky_Example_iOS' do
    platform :ios, '9.0'
    target 'Mocky_Tests_iOS' do
        inherit! :search_paths
        tests
    end
end

target 'Mocky_Example_tvOS' do
    platform :tvos, '9.0'
    target 'Mocky_Tests_tvOS' do
        inherit! :search_paths
        tests
    end
end

target 'Mocky_Example_macOS' do
    platform :macos, '10.13'
    target 'Mocky_Tests_macOS' do
        inherit! :search_paths
        tests
    end
end

post_install do |installer|
  system("rake sourcery")
end
