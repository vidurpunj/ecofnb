require 'test_helper'

class EcofnbControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ecofnb_index_url
    assert_response :success
  end

end
