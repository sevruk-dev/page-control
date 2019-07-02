Pod::Spec.new do |s|

  s.name         = "Sevruk-PageControl"
  s.version      = "1.0.0"
  s.summary      = "💥 Beautiful, animated and highly customizable UIPageControl alternative for iOS."
  s.homepage     = "https://github.com/sevruk-dev/page-control"
  s.license      = "MIT"
  s.author       = { "Vova Seuruk" => "vovaseuruk@gmail.com" }
  s.ios.deployment_target = '9.0'
  s.swift_version = '5'
  s.source       = { :git => "https://github.com/sevruk-dev/page-control.git", :tag => s.version }
  s.source_files = 'PageControl/PageControl/*.swift'

end
