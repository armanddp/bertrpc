# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bertrpc}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Preston-Werner"]
  s.date = %q{2009-05-27}
  s.email = %q{tom@mojombo.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.md",
     "Rakefile",
     "VERSION",
     "bertrpc.gemspec",
     "lib/bertrpc.rb",
     "lib/bertrpc/errors.rb",
     "lib/bertrpc/fun.rb",
     "lib/bertrpc/mod.rb",
     "lib/bertrpc/service.rb",
     "test/fun_test.rb",
     "test/mod_test.rb",
     "test/service_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/mojombo/bertrpc}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{BERTRPC is a Ruby BERT-RPC client library.}
  s.test_files = [
    "test/fun_test.rb",
     "test/mod_test.rb",
     "test/service_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<erlectricity>, [">= 1.0.1"])
    else
      s.add_dependency(%q<erlectricity>, [">= 1.0.1"])
    end
  else
    s.add_dependency(%q<erlectricity>, [">= 1.0.1"])
  end
end
