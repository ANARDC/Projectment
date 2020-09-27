# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Projectment' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'SnapKit', '~> 5.0.0'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RealmSwift'
  pod 'Unrealm'

  target 'ProjectmentTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ProjectmentUITests' do
    # Pods for testing
  end

  post_install do |installer|
     installer.pods_project.targets.each do |target|
           target.build_configurations.each do |config|
                 config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
           end
     end
 end
end