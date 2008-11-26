# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'

require 'st_html/ruing/layout/flow_layout'
require 'st_html/ruing/abstract_renderer'

class LayCR < StHtml::Ruing::AbstractRenderer
  def render x, *renderoptions
      "."
  end
end

class LayC < StHtml::Ruing::AbstractRenderer
  
  def renderer
      @r = LayCR.new unless @r
      return @r 
  end
end

class T02_FlowLayout < Test::Unit::TestCase

    def test_border_layout
        
        fl = StHtml::Ruing::Layout::FlowLayout.new :align => :left
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
