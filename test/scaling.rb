# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
require 'test/unit'
 
require 'st_html/ruing/ruing'
require 'st_html/ruing/elements/default_item.rb'

class T01bis_Scaling < Test::Unit::TestCase

    def test_scaling_wo_cache

      t = Time.new
      
      di = StHtml::Ruing::Elements::DefaultItem.new( "myname")
      
      di.render # run once to calculate internal options  
      
      for i in 0...1000 do
          assert_equal( di.renderer.render(di), di.render, 'Wrong direct rendering.')
      end

      delta = Time.new - t
      # no great expectations
      print delta  
    end
    def test_scaling_w_cache
        
      t = Time.new
      
      di = StHtml::Ruing::Elements::DefaultItem.new( "myname")
      
      di.render # run once to calculate internal options  
      di.renderer.options[:cache] = true # then cache them...
      
      for i in 0...1000 do
          assert_equal( di.renderer.render(di), di.render, 'Wrong direct rendering.')
      end

      delta = Time.new - t
      
      print delta  
    end
    
end
