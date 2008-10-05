
# Gem::Specification for Exceptional-0.0.1
# Originally generated by Echoe

--- !ruby/object:Gem::Specification 
name: exceptional
version: !ruby/object:Gem::Version 
  version: 0.0.1
platform: ruby
authors: 
- David Rice
autorequire: 
bindir: bin

date: 2008-10-02 00:00:00 +01:00
default_executable: 
dependencies: 
- !ruby/object:Gem::Dependency 
  name: json
  type: :runtime
  version_requirement: 
  version_requirements: !ruby/object:Gem::Requirement 
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        version: "0"
    version: 
- !ruby/object:Gem::Dependency 
  name: echoe
  type: :development
  version_requirement: 
  version_requirements: !ruby/object:Gem::Requirement 
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        version: "0"
    version: 
description: Exceptional is the core Ruby library for communicating with http://getexceptional.com (hosted error tracking service)
email: david@contrast.ie
executables: []

extensions: []

extra_rdoc_files: 
- lib/exceptional/agent/worker.rb
- lib/exceptional/deployed_environment.rb
- lib/exceptional/exception_data.rb
- lib/exceptional/integration/rails.rb
- lib/exceptional/rails.rb
- lib/exceptional/version.rb
- lib/exceptional.rb
- README
files: 
- exceptional.yml
- History.txt
- init.rb
- install.rb
- lib/exceptional/agent/worker.rb
- lib/exceptional/deployed_environment.rb
- lib/exceptional/exception_data.rb
- lib/exceptional/integration/rails.rb
- lib/exceptional/rails.rb
- lib/exceptional/version.rb
- lib/exceptional.rb
- Rakefile
- README
- spec/deployed_environment_spec.rb
- spec/exception_data_spec.rb
- spec/exceptional_spec.rb
- spec/spec_helper.rb
- spec/worker_spec.rb
- Manifest
- exceptional.gemspec
has_rdoc: true
homepage: http://getexceptional.com/
post_install_message: 
rdoc_options: 
- --line-numbers
- --inline-source
- --title
- Exceptional
- --main
- README
require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
  version: 
required_rubygems_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - "="
    - !ruby/object:Gem::Version 
      version: "1.2"
  version: 
requirements: []

rubyforge_project: exceptional
rubygems_version: 1.2.0
specification_version: 2
summary: Exceptional is the core Ruby library for communicating with http://getexceptional.com (hosted error tracking service)
test_files: []
