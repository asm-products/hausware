require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { canceled_at: @order.canceled_at, chargeid: @order.chargeid, confirmation: @order.confirmation, delivered_at: @order.delivered_at, email: @order.email, fulfilled_at: @order.fulfilled_at, location_id: @order.location_id, name: @order.name, phone: @order.phone, subtotal_in_cents: @order.subtotal_in_cents, tax_in_cents: @order.tax_in_cents, total_in_cents: @order.total_in_cents, user_id: @order.user_id, zipcode: @order.zipcode }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { canceled_at: @order.canceled_at, chargeid: @order.chargeid, confirmation: @order.confirmation, delivered_at: @order.delivered_at, email: @order.email, fulfilled_at: @order.fulfilled_at, location_id: @order.location_id, name: @order.name, phone: @order.phone, subtotal_in_cents: @order.subtotal_in_cents, tax_in_cents: @order.tax_in_cents, total_in_cents: @order.total_in_cents, user_id: @order.user_id, zipcode: @order.zipcode }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
