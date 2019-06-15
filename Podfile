use_frameworks!

abstract_target 'RealmConverter' do
    pod 'Realm'
    pod 'PathKit'
    pod 'CSwiftV'

    target 'RealmConverterMacOS' do
      platform :osx, '10.9'
      pod 'TGSpreadsheetWriter'
    end

    target 'RealmConverteriOS' do
      platform :ios, '10.0'
    end

    target 'RealmConverterTestsiOS' do
      platform :ios, '10.0'
      inherit! :search_paths
    end

    target 'RealmConverterTestsMacOS' do
      platform :osx, '10.9'
      inherit! :search_paths
      pod 'TGSpreadsheetWriter'
    end
end
