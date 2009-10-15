require 'rubygems'
require 'rake'

begin
  # hanna_dir = '/Users/mislav/Projects/Hanna/lib'
  hanna_dir = "/Users/id/.gem/ruby/active/gems/mislav-hanna-0.1.11/lib"
  $:.unshift hanna_dir if File.exists? hanna_dir
  require 'hanna/rdoctask'
rescue LoadError
  puts "*** Load hanna/rdoctask failed. ***"
  require 'rake'
  require 'rake/rdoctask'
end

desc 'Generate RDoc documentation for YamlDoc.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_files.include('README.rdoc', 'LICENSE', 'CHANGELOG.rdoc').
    include('lib/**/*.rb').
    exclude('lib/class_attributes.rb')

  rdoc.main = "README.rdoc" # page to start on
  rdoc.title = "yamldoc documentation"

  rdoc.rdoc_dir = 'doc' # rdoc output folder
  rdoc.options << '--inline-source' << '--charset=UTF-8'
  rdoc.options << '--webcvs=http://github.com/dreamcat4/yamldoc/tree/master/'
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "yamldoc"
    gem.summary = "A simple solution for ERB enabled YAML file."
    gem.email = "dreamcat4@gmail.com"
    gem.homepage = "http://github.com/dreamcat4/yamldoc"
    gem.authors = ["dreamcat4, Ben Johnson"]
    gem.rubyforge_project = ""
  end
  Jeweler::RubyforgeTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec
