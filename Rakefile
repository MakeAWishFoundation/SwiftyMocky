## [ Mocks Generation ] ########################################################

task :mock do
    print_info "Generating mocks - iOS"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.iOS.yml"
    print_info "Generating mocks - tvOS"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.tvOS.yml"
    print_info "Generating mocks - macOS"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.macOS.yml"
    print_info "Generating mocks - SPM"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.spm.yml"
end

task :debug do
    print_info "Generating mocks - iOS - debug"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.iOS.yml --disableCache --verbose"
    print_info "Generating mocks - tvOS - debug"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.tvOS.yml --disableCache --verbose"
    print_info "Generating mocks - macOS - debug"
    sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config .mocky.macOS.yml --disableCache --verbose"
end

## [ Tools ] ###################################################################

task :update do
    print_info "Re-Generating main template from parts"

    # Update source files
    sh "cp -Rf ./Sources/Shared/ ./Sources/SwiftyMocky"
    sh "cp -Rf ./Sources/Shared/ ./Sources/SwiftyPrototype"

    # Prepare SwiftyMocky template
    destination = "../Sources/SwiftyMocky/Mock.swifttemplate"
    sh "rm -rf #{destination}"
    sh "cd ./Templates && echo \"<%_\" > #{destination}"
    sh "cd ./Templates && echo 'let mockTypeName = \"Mock\"' >> #{destination}"
    sh "cd ./Templates && cat ArgumentsHelper.swift >> #{destination}"
    sh "cd ./Templates && echo \"_%>\" >> #{destination}"
    sh "cd ./Templates && cat Header-Mock.swifttemplate >> #{destination}"
    sh "cd ./Templates && cat Imports.swifttemplate >> #{destination}"
    sh "cd ./Templates && echo \"<%_\" >> #{destination}"
    sh "cd ./Templates && cat Current.swift >> #{destination}"
    sh "cd ./Templates && cat TemplateHelper.swift >> #{destination}"
    sh "cd ./Templates && cat Helpers.swift >> #{destination}"
    sh "cd ./Templates && cat ParameterWrapper.swift >> #{destination}"
    sh "cd ./Templates && cat TypeWrapper.swift >> #{destination}"
    sh "cd ./Templates && cat MethodWrapper.swift >> #{destination}"
    sh "cd ./Templates && cat SubscriptWrapper.swift >> #{destination}"
    sh "cd ./Templates && cat VariableWrapper.swift >> #{destination}"
    sh "cd ./Templates && echo \"_%>\" >> #{destination}"
    sh "cd ./Templates && cat Main.swifttemplate >> #{destination}"

    # Prepare SwiftyPrototype template
    destination = "../Sources/SwiftyPrototype/Prototype.swifttemplate"
    sh "rm -rf #{destination}"
    sh "cd ./Templates && echo \"<%_\" > #{destination}"
    sh "cd ./Templates && echo 'let mockTypeName = \"Prototype\"' >> #{destination}"
    sh "cd ./Templates && cat ArgumentsHelper.swift >> #{destination}"
    sh "cd ./Templates && echo \"_%>\" >> #{destination}"
    sh "cd ./Templates && cat Header-Prototype.swifttemplate >> #{destination}"
    sh "cd ./Templates && cat Imports.swifttemplate >> #{destination}"
    sh "cd ./Templates && echo \"<%_\" >> #{destination}"
    sh "cd ./Templates && cat Current.swift >> #{destination}"
    sh "cd ./Templates && cat TemplateHelper.swift >> #{destination}"
    sh "cd ./Templates && cat Helpers.swift >> #{destination}"
    sh "cd ./Templates && cat ParameterWrapper.swift >> #{destination}"
    sh "cd ./Templates && cat TypeWrapper.swift >> #{destination}"
    sh "cd ./Templates && cat MethodWrapper.swift >> #{destination}"
    sh "cd ./Templates && cat SubscriptWrapper.swift >> #{destination}"
    sh "cd ./Templates && cat VariableWrapper.swift >> #{destination}"
    sh "cd ./Templates && echo \"_%>\" >> #{destination}"
    sh "cd ./Templates && cat Main.swifttemplate >> #{destination}"
end

task :test do
    # fast test for development
    sh "rake update"
    sh "rake mock"
    sh "ice test"
end

task :xcode do
    sh "open SwiftyMocky.xcworkspace"
end

## [ Deploy ] ##################################################################

desc "Sets new version"
task :version do
    ARGV.each { |a| task a.to_sym do ; end }
    version_from = ARGV[1].to_s.strip
    version_to = ARGV[2].to_s.strip
    if version_from && !version_from.empty? && version_to && !version_to.empty?
        print("Changing version from #{version_from} -> #{version_to} !\n")
        sh("sed -i '' 's|#{version_from}|#{version_to}|g' ./.jazzy.yaml")
        sh("sed -i '' 's|#{version_from}|#{version_to}|g' ./README.md")
        sh("sed -i '' 's|#{version_from}|#{version_to}|g' ./guides/Installation.md")
        sh("sed -i '' 's|#{version_from}|#{version_to}|g' ./guides/Overview.md")
        sh("sed -i '' 's|#{version_from}|#{version_to}|g' ./SwiftyMocky-Runtime/Info.plist")
        sh("sed -i '' 's|#{version_from}|#{version_to}|g' ./Templates/Header-Mock.swifttemplate")
        sh("sed -i '' 's|#{version_from}|#{version_to}|g' ./Templates/Header-Prototype.swifttemplate")
        sh("sed -i '' 's|#{version_from}|#{version_to}|g' ./SwiftyMocky.podspec")
        sh("sed -i '' 's|#{version_from}|#{version_to}|g' ./SwiftyPrototype.podspec")
    else
        print("Missing versions!\n")
        exit(1)
    end
end

desc "Deploys new version of a binary, by pushing passed tag"
task :deploy do
    ARGV.each { |a| task a.to_sym do ; end }
    version = ARGV[1].to_s
    if version && !version.to_s.strip.empty?
        sh("git commit -m \"Deploy #{version}\"")
        sh("git push")
        sh("git tag #{version} && git push --tags")
        sh("pod trunk push")
    else
        print("Missing version!\n")
        exit(1)
    end
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
    sh "sourcekitten doc -- -workspace SwiftyMocky.xcworkspace -scheme SwiftyMocky > docs.json && jazzy --clean && rm docs.json"
end

## [ Helpers ] #################################################################

def print_info(str)
    (red,clr) = (`tput colors`.chomp.to_i >= 8) ? %W(\e[33m \e[m) : ["", ""]
    puts red, "== #{str.chomp} ==", clr
end
