require 'test_helper'

class MenusControllerTest < ActionController::TestCase
  setup do
    @menu = menus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:menus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create menu" do
    assert_difference('Menu.count') do
      post :create, menu: { friday_ending: @menu.friday_ending, friday_starting: @menu.friday_starting, location_id: @menu.location_id, monday_ending: @menu.monday_ending, monday_starting: @menu.monday_starting, name: @menu.name, permalink: @menu.permalink, position: @menu.position, saturday_ending: @menu.saturday_ending, saturday_starting: @menu.saturday_starting, sunday_ending: @menu.sunday_ending, sunday_starting: @menu.sunday_starting, thursday_ending: @menu.thursday_ending, thursday_starting: @menu.thursday_starting, tuesday_ending: @menu.tuesday_ending, tuesday_starting: @menu.tuesday_starting, wednesday_ending: @menu.wednesday_ending, wednesday_starting: @menu.wednesday_starting }
    end

    assert_redirected_to menu_path(assigns(:menu))
  end

  test "should show menu" do
    get :show, id: @menu
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @menu
    assert_response :success
  end

  test "should update menu" do
    patch :update, id: @menu, menu: { friday_ending: @menu.friday_ending, friday_starting: @menu.friday_starting, location_id: @menu.location_id, monday_ending: @menu.monday_ending, monday_starting: @menu.monday_starting, name: @menu.name, permalink: @menu.permalink, position: @menu.position, saturday_ending: @menu.saturday_ending, saturday_starting: @menu.saturday_starting, sunday_ending: @menu.sunday_ending, sunday_starting: @menu.sunday_starting, thursday_ending: @menu.thursday_ending, thursday_starting: @menu.thursday_starting, tuesday_ending: @menu.tuesday_ending, tuesday_starting: @menu.tuesday_starting, wednesday_ending: @menu.wednesday_ending, wednesday_starting: @menu.wednesday_starting }
    assert_redirected_to menu_path(assigns(:menu))
  end

  test "should destroy menu" do
    assert_difference('Menu.count', -1) do
      delete :destroy, id: @menu
    end

    assert_redirected_to menus_path
  end
end
