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
 
require 'test/unit'

require 'st_html/ruing/layout/flow_layout'
require 'st_html/ruing/abstract_renderer'

class LayCR < StHtml::Ruing::AbstractRenderer
  def render x, *renderoptions
      "."
  end
end

class LayC < StHtml::Ruing::AbstractRenderer
  def initialize
      @r = nil
  end
  def renderer
      @r = LayCR.new unless @r
      return @r 
  end
end

class T02_FlowLayout < Test::Unit::TestCase

    def test_border_layout
        
        assert_nothing_raised() {
            StHtml::Ruing::Layout::FlowLayout.new :align => :left
        }
    end
    
    def test_layout
        
        fl = StHtml::Ruing::Layout::FlowLayout.new :align => :left
        fl.add nil, LayC.new 
        fl.add nil, LayC.new 
        fl.add nil, LayC.new 
        fl.add nil, LayC.new 
        
        assert_equal \
%-<div style="align: left">- +
%-<span>.</span>- +
%-<span>.</span>- +
%-<span>.</span>- +
%-<span>.</span>- +
%-</div>-\
            ,fl.layout( :builder => Builder::XmlMarkup.new(:indent=>0) )
    end
end
