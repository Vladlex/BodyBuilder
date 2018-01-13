Pod::Spec.new do |s|  
    s.name              = 'BodyBuilder'
    s.version           = '1.0.0'
    s.summary           = 'Small SDK to help to building HTTP request body'
    s.homepage          = 'https://github.com/Vladlex/BodyBuilder.git'

    s.author            = { 'Name' => 'vladlexion@gmail.com' }
    s.license           = { :type => 'Apache-2.0', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :http => 'https://github.com/Vladlex/BodyBuilder.git' }

    s.ios.deployment_target = '8.0'
    s.ios.vendored_frameworks = 'MySDK.framework'

    s.source_files = "BodyBuilder/*"

end  
