## [ Mocks Generation ] ########################################################

task :mock do
  print_info "Generating mocks"
	sh "Pods/Sourcery/bin/sourcery --config mocky.yml"
end

task :debug do
  print_info "Generating mocks - debug"
	sh "Pods/Sourcery/bin/sourcery --config mocky.yml --disableCache --verbose"
end

## [ CocoaPods ] ###############################################################

desc "Install project dependencies"
desc "In case of need, pod repo update will be invoked"
task :pod_install do
	begin
		sh "pod install"
	rescue
	  print_info "Install failed - trying repo update"
		sh "pod repo update"
		sh "pod install"
	end
end

## [ Docs ] ####################################################################

desc "Update docs"
task :docs do
  print_info "Updating docs"
  sh "sourcekitten doc -- -workspace Mocky.xcworkspace -scheme SwiftyMocky > docs.json && jazzy --clean --skip-undocumented && rm docs.json"
end

## [ Helpers ] #################################################################

def print_info(str)
  (red,clr) = (`tput colors`.chomp.to_i >= 8) ? %W(\e[33m \e[m) : ["", ""]
  puts red, "== #{str.chomp} ==", clr
end
