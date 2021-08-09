require "test_helper"

class Say1ControllerTest < ActionDispatch::IntegrationTest
  test "should get hello" do
    get say1_hello_url
    assert_response :success
  end

  test "should get goodbye4" do
    get say1_goodbye4_url
    assert_response :success
  end
end
