# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Portal' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Portal

  pod 'GCDWebServer', '~> 3.3.2'
  pod 'GCDWebServer/WebUploader', '~> 3.3.2'
  pod 'GCDWebServer/WebDAV', '~> 3.3.2'
  pod 'SnapKit', '~> 0.30.0.beta2'
  pod 'ReactiveCocoa', '~> 4.2.1'
  
  def pods_for_testing
    pod 'Quick', '~> 0.9.2'
    pod 'Nimble', '~> 4.1.0'
  end

  target 'PortalTests' do
    inherit! :search_paths
    pods_for_testing
  end

  target 'PortalUITests' do
    inherit! :search_paths
    pods_for_testing
  end

end
