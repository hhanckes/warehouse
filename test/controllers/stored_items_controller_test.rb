require 'test_helper'

class StoredItemsControllerTest < ActionController::TestCase
  setup do
    @stored_item = stored_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stored_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stored_item" do
    assert_difference('StoredItem.count') do
      post :create, stored_item: { assigned_value: @stored_item.assigned_value, description: @stored_item.description, name: @stored_item.name, order_storage_item_id: @stored_item.order_storage_item_id }
    end

    assert_redirected_to stored_item_path(assigns(:stored_item))
  end

  test "should show stored_item" do
    get :show, id: @stored_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stored_item
    assert_response :success
  end

  test "should update stored_item" do
    patch :update, id: @stored_item, stored_item: { assigned_value: @stored_item.assigned_value, description: @stored_item.description, name: @stored_item.name, order_storage_item_id: @stored_item.order_storage_item_id }
    assert_redirected_to stored_item_path(assigns(:stored_item))
  end

  test "should destroy stored_item" do
    assert_difference('StoredItem.count', -1) do
      delete :destroy, id: @stored_item
    end

    assert_redirected_to stored_items_path
  end
end
