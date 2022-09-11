require "test_helper"

class Public::AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_admin_index_url
    assert_response :success
  end
end
