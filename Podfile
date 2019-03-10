source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

inhibit_all_warnings!

target 'BeyondChallenge' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BeyondChallenge
  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'SnapKit', '~> 4.0.0'
  pod "RxGesture"
  
  #back-end frameworks
  pod 'Moscapsule', :git => 'https://github.com/flightonary/Moscapsule.git'
  pod 'OpenSSL-Universal'

  target 'BeyondChallengeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BeyondChallengeUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
