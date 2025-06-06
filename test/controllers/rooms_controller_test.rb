require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get own" do
    get rooms_own_url
    assert_response :success
  end
end
