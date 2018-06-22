# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CoMarkdown' do
  use_modular_headers!

  post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.0'
    end
  end
end

  pod 'MarkdownView', path: '../MarkdownView-master'
  pod 'Google-Diff-Match-Patch', path: '../google-diff-match-patch-Objective-C-master'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'Toast-Swift'
end
