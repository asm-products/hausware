require 'test_helper'

class Admin::OrgsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
