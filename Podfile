# Uncomment the next line to define a global platform for your project
# platform :ios, '14.1'

target 'ARHitBalls' do
 
  use_frameworks!

	pod 'FirebaseAuth'
	pod 'FirebaseCore'
  pod 'GoogleSignIn'
  pod 'FirebaseFirestore'
  pod 'FirebaseFirestoreSwift'
		
  # Pods for ARHitBalls

  post_install do |installer|
      installer.generated_projects.each do |project|
            project.targets.each do |target|
                target.build_configurations.each do |config|
                    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
                 end
            end
     end
  end
  
end
