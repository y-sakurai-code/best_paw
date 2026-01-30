require "test_helper"

class Admin::ReviewsManagementsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_reviews_managements_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_reviews_managements_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_reviews_managements_destroy_url
    assert_response :success
  end
end
