# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Portal' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Portal
  
  pod 'SnapKit'
  pod 'ReactiveCocoa', '5.0.0-alpha.2'
  
  def pods_for_testing
    pod 'Quick'
    pod 'Nimble'
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
