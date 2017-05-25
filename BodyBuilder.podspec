Pod::Spec.new do |s|  
    s.name              = 'BodyBuilder'
    s.version           = '1.0.0'
    s.summary           = 'Small SDK to help to building HTTP request body'
#    s.homepage          = ''

    s.author            = { 'Name' => 'vladlexion@gmail.com' }
    s.license           = { :type => 'Apache-2.0', :file => 'LICENSE' }

    s.platform          = :ios
#    s.source            = { :http => 'http://example.com/sdk/1.0.0/MySDK.zip' }

    s.ios.deployment_target = '8.0'
    s.ios.vendored_frameworks = 'MySDK.framework'
end  
