Pod::Spec.new do |s|
  s.name             = 'StickyScrollView'
  s.version          = '0.1.1'
  s.license          = 'MIT'
  s.summary          = 'A scroll view with sticky header'
  s.homepage         = 'https://github.com/enzoliu/StickyScrollView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Enzo Liu' => 'item.search@gmail.com' }
  s.source           = { :git => 'https://github.com/enzoliu/StickyScrollView.git', :tag => '0.1.1' }

  s.ios.deployment_target = '8.0'

  s.source_files = 'src/*.{swift,m,h}'
  

  s.requires_arc = true  
end
