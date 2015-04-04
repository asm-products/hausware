require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  setup do
    @location = locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location" do
    assert_difference('Location.count') do
      post :create, location: { city: @location.city, country_code: @location.country_code, email: @location.email, timezone: @location.timezone, friday_closing: @location.friday_closing, friday_opening: @location.friday_opening, latitude: @location.latitude, longitude: @location.longitude, monday_closing: @location.monday_closing, monday_opening: @location.monday_opening, name: @location.name, permalink: @location.permalink, phone: @location.phone, saturday_closing: @location.saturday_closing, saturday_opening: @location.saturday_opening, state_province_region: @location.state_province_region, street_address1: @location.street_address1, street_address2: @location.street_address2, sunday_closing: @location.sunday_closing, sunday_opening: @location.sunday_opening, thursday_closing: @location.thursday_closing, thursday_opening: @location.thursday_opening, tuesday_closing: @location.tuesday_closing, tuesday_opening: @location.tuesday_opening, wednesday_closing: @location.wednesday_closing, wednesday_opening: @location.wednesday_opening, zip_postal_code: @location.zip_postal_code }
    end

    assert_redirected_to location_path(assigns(:location))
  end

  test "should show location" do
    get :show, id: @location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @location
    assert_response :success
  end

  test "should update location" do
    patch :update, id: @location, location: { city: @location.city, country_code: @location.country_code, email: @location.email, timezone: @location.timezone, friday_closing: @location.friday_closing, friday_opening: @location.friday_opening, latitude: @location.latitude, longitude: @location.longitude, monday_closing: @location.monday_closing, monday_opening: @location.monday_opening, name: @location.name, permalink: @location.permalink, phone: @location.phone, saturday_closing: @location.saturday_closing, saturday_opening: @location.saturday_opening, state_province_region: @location.state_province_region, street_address1: @location.street_address1, street_address2: @location.street_address2, sunday_closing: @location.sunday_closing, sunday_opening: @location.sunday_opening, thursday_closing: @location.thursday_closing, thursday_opening: @location.thursday_opening, tuesday_closing: @location.tuesday_closing, tuesday_opening: @location.tuesday_opening, wednesday_closing: @location.wednesday_closing, wednesday_opening: @location.wednesday_opening, zip_postal_code: @location.zip_postal_code }
    assert_redirected_to location_path(assigns(:location))
  end

  test "should destroy location" do
    assert_difference('Location.count', -1) do
      delete :destroy, id: @location
    end

    assert_redirected_to locations_path
  end
end
