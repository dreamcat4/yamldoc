# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{yamldoc}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["dreamcat4, Ben Johnson"]
  s.date = %q{2009-10-12}
  s.email = %q{dreamcat4@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "CHANGELOG.rdoc",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "init.rb",
     "lib/clia.rb",
     "lib/yamldoc.rb",
     "rails/init.rb",
     "spec/new.rb",
     "spec/settings.rb",
     "spec/settings.yml",
     "spec/settings2.rb",
     "spec/spec_helper.rb",
     "spec/yamldoc_spec.rb",
     "yamldoc.gemspec"
  ]
  s.homepage = %q{http://github.com/dreamcat4/yamldoc}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A simple solution for ERB enabled YAML file.}
  s.test_files = [
    "spec/new.rb",
     "spec/settings.rb",
     "spec/settings2.rb",
     "spec/spec_helper.rb",
     "spec/yamldoc_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
