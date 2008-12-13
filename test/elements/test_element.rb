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
 
  #
  # Please read the testing policy for elements at
  # 
  #   ./readme_elements_test.txt
  #
  
module TestElement 

    def test_creation
      assert false, "Please override this method(creation, #{self})"
    end
   
    def test_renderer_initialization
      assert false, "Please override this method(renderer_initialization, #{self})"
    end
    
    def test_options
      assert false, "Please override this method(options, #{self})"
    end
    
    def test_render_editable
      assert false, "Please override this method(render_editable, #{self})"
    end
    
    def test_render_not_editable
      assert false, "Please override this method(render_not_editable, #{self})"
    end
end
