use_frameworks!

target 'AlamofirePlayground' do
pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire'
pod 'Alamofire-SwiftyJSON', :podspec => 'https://raw.githubusercontent.com/pdutourgeerling/Alamofire-SwiftyJSON-Podspec/master/Alamofire-SwiftyJSON.podspec'
pod 'Realm', :git => 'http://github.com/realm/realm-cocoa.git', :branch => 'swift-2.0'
pod 'RealmSwift', :git => 'http://github.com/realm/realm-cocoa.git', :branch => 'swift-2.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
    end
  end
end
