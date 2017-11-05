task :mock do
	sh "Pods/Sourcery/bin/sourcery --config mocky.yml --disableCache"
end

task :debug do
	sh "Pods/Sourcery/bin/sourcery --config mocky.yml --disableCache --verbose"
end

desc "Install project dependencies"
desc "In case of need, pod repo update will be invoked"
task :pod_install do
	begin
		sh "pod install"
	rescue
		sh "pod repo update"
		sh "pod install"
	end
end
