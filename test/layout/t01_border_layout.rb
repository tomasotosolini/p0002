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
        
        r = bl.layout( :builder => Builder::XmlMarkup.new(:indent=>0) )
        
        a = %-<table>\
<tr><td colspan="3" class="top">.</td></tr>\
<tr><td class="left"></td><td class="center">.</td><td class="right">.</td></tr>\
<tr><td colspan="3" class="bottom"></td></tr>\
</table>-
        b = %-<table>\
<tr><td class="top" colspan="3">.</td></tr>\
<tr><td class="left"></td><td class="center">.</td><td class="right">.</td></tr>\
<tr><td class="bottom" colspan="3"></td></tr>\
</table>-
        
        assert(  a.eql?( r ) || b.eql?( r ) )

    end
end
