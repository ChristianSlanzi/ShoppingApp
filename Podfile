source 'https://github.com/christianslanzi/Specs.git'
source 'https://github.com/CocoaPods/Specs/blob/master/Specs/9/4/5/RealmSwift/10.1.0/RealmSwift.podspec.json'

platform :ios, '13.0'

workspace 'ShoppingApp.xcworkspace'

target 'ShoppingApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  xcodeproj 'ShoppingApp.xcodeproj'
  # Pods for ShoppingApp
  pod 'RealmSwift'
  pod 'Overture'
  pod 'CS_Common_Utils', git: 'https://github.com/christianslanzi/CS_Common_Utils.git'

  target 'ShoppingAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
