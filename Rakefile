# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

require 'rubygems'

require 'fileutils'

require 'rake'
require 'rake/clean'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'


require 'lib/version'

spec = Gem::Specification.new do |s|

    s.name              = "st_html"
    s.version           = StHtml::VERSION
    s.authors           = [ "Stefano Salvador", "Tomaso Tosolini" ]
    s.email             = "stefano dot salvador at gmail dot com, tomaso dot tosolini at gmail dot com"
    s.platform          = Gem::Platform::RUBY
    s.summary           = "html rendering and presentation library"

    s.require_path      = "lib"
#    s.autorequire       = "st_html"
    s.test_file         = "test/tests.rb"
    s.has_rdoc          = false
    s.extra_rdoc_files  = [ ]

    files = FileList[ "{lib,test}/**/*" ]
#    files.exclude "rdoc" 
#    files.exclude "extras" 
    s.files = files.to_a
end

task :default => [ :clean, :repackage ]

#
# Create a task for generating RDOC
#
Rake::RDocTask.new do |rd|

    rd.main = "Readme"
    rd.rdoc_dir = "doc"
    rd.rdoc_files.include("Readme", "Changelog", "lib/**/*.rb")
    rd.title = "StHtml documentation"
    rd.options << '-N' # line numbers
    rd.options << '-S' # inline source
end

#
# Add rdoc deps to doc task
#
task :doc => [:rdoc]

#
# The default 'test'
#
Rake::TestTask.new(:test) do |t|
    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList['test/tests.rb']
    t.verbose = true
end
