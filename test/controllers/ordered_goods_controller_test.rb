require 'test_helper'

class OrderedGoodsControllerTest < ActionController::TestCase
  setup do
    @ordered_good = ordered_goods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ordered_goods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ordered_good" do
    assert_difference('OrderedGood.count') do
      post :create, ordered_good: { canceled_at: @ordered_good.canceled_at, fulfilled_at: @ordered_good.fulfilled_at, good_id: @ordered_good.good_id, name: @ordered_good.name, order_id: @ordered_good.order_id, quantity: @ordered_good.quantity, subtotal_in_cents: @ordered_good.subtotal_in_cents }
    end

    assert_redirected_to ordered_good_path(assigns(:ordered_good))
  end

  test "should show ordered_good" do
    get :show, id: @ordered_good
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ordered_good
    assert_response :success
  end

  test "should update ordered_good" do
    patch :update, id: @ordered_good, ordered_good: { canceled_at: @ordered_good.canceled_at, fulfilled_at: @ordered_good.fulfilled_at, good_id: @ordered_good.good_id, name: @ordered_good.name, order_id: @ordered_good.order_id, quantity: @ordered_good.quantity, subtotal_in_cents: @ordered_good.subtotal_in_cents }
    assert_redirected_to ordered_good_path(assigns(:ordered_good))
  end

  test "should destroy ordered_good" do
    assert_difference('OrderedGood.count', -1) do
      delete :destroy, id: @ordered_good
    end

    assert_redirected_to ordered_goods_path
  end
end
