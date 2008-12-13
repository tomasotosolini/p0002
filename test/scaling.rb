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
 
require 'st_html/ruing/ruing'
require 'st_html/ruing/elements/default_item.rb'

class T01bis_Scaling < Test::Unit::TestCase

    def test_scaling_wo_cache

      t = Time.new
      
      di = StHtml::Ruing::Elements::DefaultItem.new( "myname")
      
      di.render # run once to calculate internal options  
      
      for i in 0...1000 do
          assert_equal( di.renderer.render(di), di.render )
      end

      delta = Time.new - t
      # not great expectations
      print delta  
    end
    def test_scaling_w_cache
        
      t = Time.new
      
      di = StHtml::Ruing::Elements::DefaultItem.new( "myname")
      
      di.render # run once to calculate internal options  
      di.renderer.options[:cache] = true # then cache them...
      
      for i in 0...1000 do
          assert_equal( di.renderer.render(di), di.render )
      end

      delta = Time.new - t
      
      print delta  
    end
    
end
