## [ Mocks Generation ] ########################################################

task :mock do
  print_info "Generating mocks"
	sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config mocky.yml"
end

task :debug do
  print_info "Generating mocks - debug"
	sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config mocky.yml --disableCache --verbose"
end

## [ Sourcery ] ################################################################

desc "Download prebuilt sourcery app."
desc "Can specify version as argument (default is 4.0.2)"
task :sourcery do
    ARGV.each { |a| task a.to_sym do ; end }
    sh "sh get_sourcery.sh " + ARGV[1].to_s + " " + ARGV[2].to_s
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
