# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'

require 'st_html/ruing/layout/border_layout'
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

class T01_BorderLayout < Test::Unit::TestCase

    def test_border_layout
        
        bl = StHtml::Ruing::Layout::BorderLayout.new :top => LayC.new
        assert_not_nil bl.layout_components[StHtml::Ruing::Layout::BorderLayout::TOP], 'We expected a top renderer.'
        assert_nil bl.layout_components[StHtml::Ruing::Layout::BorderLayout::LEFT], 'We do not expected a left renderer.'
        
        bl = StHtml::Ruing::Layout::BorderLayout.new :top => LayC.new 
    end
    
    def test_layout
        
        bl = StHtml::Ruing::Layout::BorderLayout.new :top => LayC.new , \
            :center => LayC.new ,\
            :right => LayC.new 
        
        assert_equal \
%-<table>- +
%-<tr><td class="top" colspan="3">.</td></tr>- +
%-<tr><td class="left"></td><td class="center">.</td><td class="right">.</td></tr>- +
%-<tr><td class="bottom" colspan="3"></td></tr>- +
%-</table>-\
            ,bl.layout( :builder => Builder::XmlMarkup.new(:indent=>0) )
    end
end
