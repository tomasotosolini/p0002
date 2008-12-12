# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 


require 'rubygems'
gem 'ruby-debug'
require 'ruby-debug' 

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

# Including customized assertions 
require 'test/custom/test_custom'

# basic things
require 'test/t01_views_factory'
require 'test/t02_views_render'
require 'test/t03_vararg'

  # renderer, validator, etc
require 'test/t04_abstract_renderer'
require 'test/t05_abstract_validator'

  # layout
require 'test/layout/t01_border_layout'
require 'test/layout/t02_flow_layout'


  # items, container
require 'test/t06_abstract_item'
require 'test/t07_abstract_container'


  # items, container
require 'test/elements/t01_default_item'
require 'test/elements/t02_text_field'
require 'test/elements/t03_hidden'
require 'test/elements/t03bis_factory'
