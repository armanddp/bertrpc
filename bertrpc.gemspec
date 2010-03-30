# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bertrpc}
  s.version = "1.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Preston-Werner"]
  s.date = %q{2010-03-30}
  s.email = %q{tom@mojombo.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "History.txt",
     "LICENSE",
     "README.md",
     "Rakefile",
     "VERSION",
     "bertrpc.gemspec",
     "lib/bertrpc.rb",
     "lib/bertrpc/action.rb",
     "lib/bertrpc/encodes.rb",
     "lib/bertrpc/errors.rb",
     "lib/bertrpc/mod.rb",
     "lib/bertrpc/request.rb",
     "lib/bertrpc/service.rb",
     "lib/erpc/action.rb",
     "lib/erpc/decode.rb",
     "lib/erpc/decodes.rb",
     "lib/erpc/encode.rb",
     "lib/erpc/error.rb",
     "lib/erpc/mod.rb",
     "lib/erpc/request.rb",
     "test/action_test.rb",
     "test/encodes_test.rb",
     "test/error_test.rb",
     "test/mod_test.rb",
     "test/request_test.rb",
     "test/service_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/mojombo/bertrpc}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{BERTRPC is a Ruby BERT-RPC client library.}
  s.test_files = [
    "test/action_test.rb",
     "test/encodes_test.rb",
     "test/error_test.rb",
     "test/mod_test.rb",
     "test/request_test.rb",
     "test/service_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bert>, [">= 1.1.0", "< 2.0.0"])
    else
      s.add_dependency(%q<bert>, [">= 1.1.0", "< 2.0.0"])
    end
  else
    s.add_dependency(%q<bert>, [">= 1.1.0", "< 2.0.0"])
  end
end

