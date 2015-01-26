require 'test_helper'

class TiendaTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Tienda
  end

  test "root path is set" do
    assert_equal File.expand_path('../../', __FILE__), Tienda.root
  end

end
