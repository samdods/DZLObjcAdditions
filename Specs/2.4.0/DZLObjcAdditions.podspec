Pod::Spec.new do |s|
  s.name         = "DZLObjcAdditions"
  s.version      = "2.4.0"
  s.summary      = "Handy Objective-C 'Extensions'"
  s.homepage     = "https://github.com/samdods/DZLObjcAdditions"
  s.license      = 'MIT'
  s.author       = { "Sam Dods" => "dods.sam@gmail.com" }
  s.ios.platform = :ios, '4.0'
  s.osx.platform = :osx, '10.9'
  s.source       = { :git => "https://github.com/samdods/DZLObjcAdditions.git", :tag => s.version.to_s }
  s.source_files  = 'DZLObjcAdditions/**/*.{h,m}'
  s.frameworks = 'Foundation'
  s.requires_arc = true
end
