require "test_helper"

class TurnsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get turns_create_url
    assert_response :success
  end
end
