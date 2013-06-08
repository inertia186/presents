require "test/unit"
require "rails"
require "presents"

class TestPresents < Test::Unit::TestCase
  class Foo
    def name
      "Foo"
    end
  end
  class FooPresenter < Presents::BasePresenter
    presents :foo
    def name_upcase
      foo.name.upcase
    end
  end

  def test_base_presenter_wraps_object
    assert_equal "FOO", FooPresenter.new(Foo.new).name_upcase
  end
  
  def test_presentable_array
    my_array = [Foo.new, Foo.new, Foo.new]
    exec = 0
    
    my_array.present_each do |thing|
      assert_equal "FOO", thing.name_upcase
      exec = exec + 1
    end
    
    assert_equal my_array.length, exec
  end
end
