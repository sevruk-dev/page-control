Pod::Spec.new do |s|

  s.name         = "InsiderPageControl"
  s.version      = "0.0.1"
  s.summary      = "PageControl with aimation on switch."
  s.homepage     = "https://github.com/insiderdev/page-control/"
  s.license      = "MIT"
  s.author       = { "Vova Seuruk" => "vovaseuruk@gmail.com" }
  s.ios.deployment_target = '9.0'
  s.swift_version = '3.2'
  s.source       = { :git => "https://github.com/insiderdev/page-control.git", :tag => s.version }
  s.source_files = 'PageControl/PageControl/*.swift'

end
