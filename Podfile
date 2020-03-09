# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
inhibit_all_warnings!
source 'https://github.com/CocoaPods/Specs.git'

def portal_pods
  pod 'Charts', :git => 'https://github.com/danielgindi/Charts.git', :commit => '97587d04ed51f4e38e3057da51867d8805995a56'
end

def test_pods
	
end

target 'Portal' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Portal

  portal_pods

  target 'PortalTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PortalUITests' do
    # Pods for testing
  end

end
