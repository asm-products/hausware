require 'test_helper'

class Reception::OrgsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
