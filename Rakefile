## [ Mocks Generation ] ########################################################

task :mock do
    print_info "Generating mocks - iOS"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.iOS.yml"
    print_info "Generating mocks - tvOS"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.tvOS.yml"
    print_info "Generating mocks - macOS"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.macOS.yml"
end

task :debug do
    print_info "Generating mocks - iOS - debug"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.iOS.yml --disableCache --verbose"
    print_info "Generating mocks - tvOS - debug"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.tvOS.yml --disableCache --verbose"
    print_info "Generating mocks - macOS - debug"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.macOS.yml --disableCache --verbose"
end

## [ Sourcery ] ################################################################

desc "Download prebuilt sourcery app."
desc "Can specify version as argument (default is 4.2)"
task :sourcery do
    ARGV.each { |a| task a.to_sym do ; end }
    sh "sh get_sourcery.sh " + ARGV[1].to_s + " " + ARGV[2].to_s
end

## [ CocoaPods ] ###############################################################

desc "Install project dependencies"
desc "In case of need, pod repo update will be invoked"
task :pods do
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
