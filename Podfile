source "https://cdn.cocoapods.org/"

# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'app' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for app
  pod 'SwiftyBeaver'

  #Network	
  pod 'Alamofire'
  pod 'Moya'
  pod 'Moya/RxSwift'

  target 'appTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'appUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
