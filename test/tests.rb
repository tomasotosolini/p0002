# 
#     StHtml
# 
#   Il presente file fa parte del progetto StHtml che viene distribuito 
#   secondo le clausole della licenza MIT. Nella directory base(root) del 
#   progetto è presente una copia della licenza.
# 
#   For non italian speakers, please be able to translate into your native 
#   language the license terms expressed by the previous statements. The only
#   valid license is the one expressed in those statements.
# 
#   Copyright Tomaso Tosolini/Stefano Salvador - 2007-2074
#   Please contact at gmail: tomaso.tosolini
# 

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
require 'test/elements/t00_factory'
require 'test/elements/t01_default_item'
require 'test/elements/t02_text_field'
require 'test/elements/t03_hidden'
require 'test/elements/t04_check'
