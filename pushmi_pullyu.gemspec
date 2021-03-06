lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pushmi_pullyu/version'

Gem::Specification.new do |spec|
  spec.name          = 'pushmi_pullyu'
  spec.version       = PushmiPullyu::VERSION
  spec.authors       = ['Shane Murnaghan']
  spec.email         = ['murnagha@ualberta.ca']

  spec.summary       = 'Ruby application to manage flow of content from Fedora into Swift for preservation'
  spec.homepage      = 'https://github.com/ualbertalib/pushmi_pullyu'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.3.1'

  spec.add_runtime_dependency 'activerecord', '>= 5.1.5', '< 5.3.0'
  spec.add_runtime_dependency 'activesupport', '~> 5.0'
  spec.add_runtime_dependency 'bagit', '~> 0.4'
  spec.add_runtime_dependency 'connection_pool', '~> 2.2'
  spec.add_runtime_dependency 'daemons', '~> 1.2', '>= 1.2.4'
  spec.add_runtime_dependency 'minitar', '~> 0.7'
  spec.add_runtime_dependency 'openstack', '~> 3.3', '>= 3.3.10'
  spec.add_runtime_dependency 'pg', '>= 1.0', '< 1.2'
  spec.add_runtime_dependency 'rdf', '>= 1.99', '< 4.0'
  spec.add_runtime_dependency 'rdf-n3', '>= 1.99', '< 4.0'
  spec.add_runtime_dependency 'redis', '>= 3.3', '< 5.0'
  spec.add_runtime_dependency 'rest-client', '>= 1.8', '< 3.0'
  spec.add_runtime_dependency 'rollbar', '~> 2.18'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'danger', '~> 5.2'
  spec.add_development_dependency 'pry', '~> 0.10', '>= 0.10.4'
  spec.add_development_dependency 'pry-byebug', '~> 3.6'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.51'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.10'
  spec.add_development_dependency 'timecop', '~> 0.8'
  spec.add_development_dependency 'vcr', '~> 4.0'
  spec.add_development_dependency 'webmock', '~> 3.3'
end
