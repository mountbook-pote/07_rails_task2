require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get reservations" do
    get reservations_reservations_url
    assert_response :success
  end
end
