require "test_helper"

class ContactControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get contact_new_url
    assert_response :success
  end

  test "should get confirm" do
    get contact_confirm_url
    assert_response :success
  end

  test "should get done" do
    get contact_done_url
    assert_response :success
  end
end
