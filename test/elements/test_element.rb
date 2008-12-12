 
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
