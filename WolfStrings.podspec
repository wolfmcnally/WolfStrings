Pod::Spec.new do |s|
    s.name             = 'WolfStrings'
    s.version          = '2.0.0'
    s.summary          = 'A library of conveniences for working with Swift strings and NSAttributed strings.'

    # s.description      = <<-DESC
    # TODO: Add long description of the pod here.
    # DESC

    s.homepage         = 'https://github.com/wolfmcnally/WolfStrings'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Wolf McNally' => 'wolf@wolfmcnally.com' }
    s.source           = { :git => 'https://github.com/wolfmcnally/WolfStrings.git', :tag => s.version.to_s }

    s.source_files = 'Sources/WolfStrings/**/*'

    s.swift_version = '5.0'

    s.ios.deployment_target = '9.3'
    s.macos.deployment_target = '10.13'
    s.tvos.deployment_target = '11.0'

    s.module_name = 'WolfStrings'

    s.dependency 'WolfPipe'
    s.dependency 'WolfNumerics'
    s.dependency 'ExtensibleEnumeratedName'
    s.dependency 'WolfWith'
    s.dependency 'WolfOSBridge'
end
