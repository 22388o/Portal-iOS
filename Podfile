# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

inhibit_all_warnings!
use_modular_headers!

source 'https://github.com/CocoaPods/Specs.git'

def portal_pods
  pod 'BitcoinCore.swift', git: 'https://github.com/horizontalsystems/bitcoin-kit-ios.git'
  pod 'BitcoinKit.swift', git: 'https://github.com/horizontalsystems/bitcoin-kit-ios.git'
  pod 'HsToolKit.swift', git: 'https://github.com/horizontalsystems/hs-tool-kit-ios'
  pod 'Hodler.swift', git: 'https://github.com/horizontalsystems/bitcoin-kit-ios.git'
  pod 'HdWalletKit.swift', git: 'https://github.com/horizontalsystems/hd-wallet-kit-ios'
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
