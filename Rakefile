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

#    [ 'rufus-lru', 
#      'rufus-scheduler', 
#      'rufus-dollar',
#      'rufus-eval',
#      'rufus-verbs' ].each do |d|
#
#        s.requirements << d
#        s.add_dependency d
#    end

    files = FileList[ "{lib,test}/**/*" ]
#    files.exclude "rdoc" 
#    files.exclude "extras" 
    s.files = files.to_a
end

#extras_spec = Gem::Specification.new do |s|
#
#    s.name              = "openwferu-extras"
#    s.version           = OpenWFE::OPENWFERU_VERSION
#    s.authors           = [ "John Mettraux" ]
#    s.email             = "john at openwfe dot org"
#    s.homepage          = "http://openwferu.rubyforge.org/"
#    s.platform          = Gem::Platform::RUBY
#    s.summary           = "OpenWFEru extras (sqs, csv, ...)"
#    s.require_path      = "lib"
#    s.autorequire       = "openwferu-extras"
#    s.has_rdoc          = false
#
#    #[ 'rufus-decision', 'rufus-sqs' ].each do |d|
#    #    s.requirements << d
#    #    s.add_dependency d
#    #end
#
#    s.files = FileList[
#        "lib/openwfe/extras/**/*"
#    ].to_a
#end

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
# Create the various openwferu[-.*] gems
#
Rake::GemPackageTask.new(spec) do |pkg|
    #pkg.need_tar = true
end
#Rake::GemPackageTask.new(extras_spec) do |pkg|
#    #pkg.need_tar = true
#end

##
## Packaging the source
##
#Rake::PackageTask.new("openwferu", OpenWFE::OPENWFERU_VERSION) do |pkg|
#
#    pkg.need_zip = true
#    pkg.package_files = FileList[
#        "Rakefile",
#        "*.txt",
#        "bin/**/*",
#        "doc/**/*",
#        "examples/**/*",
#        "lib/**/*",
#        "test/**/*"
#    ].to_a
#    pkg.package_files.delete("rc.txt")
#    pkg.package_files.delete("MISC.txt")
#    class << pkg
#        def package_name
#            "#{@name}-#{@version}-src"
#        end
#    end
#end


#
# The default 'test'
#
Rake::TestTask.new(:test) do |t|
    t.libs << "test"
    t.test_files = FileList['test/tests.rb']
    t.verbose = true
end













