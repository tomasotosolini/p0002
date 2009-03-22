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

  # items, container
require 'test/t06_abstract_item'
require 'test/t07_abstract_container'

  # items, container
require 'test/elements/tests'

  # layout ( this tests make sense only when there is a container: 
  # cfr. st_html/ruing/layout_manager.rb and 
  # st_html/ruing/elements/layout_manager.rb )
require 'test/layout/tests'

