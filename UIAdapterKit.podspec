#
# Be sure to run `pod lib lint UIAdapterKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                    = 'UIAdapterKit'
  s.version                 = '0.7.1'
  s.summary                 = 'A set of declarative adapters.'

  s.description             = <<-DESC
A set of adapters useful to define UITableView and UICollectionView in a declarative way.
                       DESC

  s.homepage                = 'https://github.com/andreadelfante/UIAdapterKit'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'andreadelfante' => 'andreadelfante94@gmail.com' }
  s.source                  = { :git => 'https://github.com/andreadelfante/UIAdapterKit.git', :tag => s.version.to_s }

  s.default_subspec         = 'Basic'
  
  s.swift_version           = '5.0'
  s.ios.deployment_target   = '8.0'
  
  s.subspec 'Basic' do |basic|
    basic.source_files      = 'UIAdapterKit/Classes/**/*'
  end

  s.subspec 'Realm' do |realm|
    realm.source_files      = ['UIAdapterKit/Classes/**/*', 'UIAdapterKit-Realm/Classes/**/*']
    
    realm.dependency 'RealmSwift'
  end
  
  s.subspec 'Common' do |common|
    common.source_files     = ['UIAdapterKit/Classes/**/*', 'UIAdapterKit-Common/Classes/**/*']
  end
end
