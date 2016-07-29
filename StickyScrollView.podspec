Pod::Spec.new do |s|
  s.name             = 'StickyScrollView'
  s.version          = '0.1.0'
  s.license          = 'MIT'
  s.summary          = 'This is a sticky scroll view like [CSStickyHeaderFlowLayout] (https://github.com/jamztang/CSStickyHeaderFlowLayout), and is designed for UIScrollView.'
  s.homepage         = 'https://github.com/enzoliu/StickyScrollView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Enzo Liu' => 'item.search@gmail.com' }
  s.source           = { :git => 'https://github.com/enzoliu/StickyScrollView.git', :tag => '0.1.0' }

  s.ios.deployment_target = '8.0'

  s.source_files = 'src/*.swift'
  

  s.requires_arc = true  
end
