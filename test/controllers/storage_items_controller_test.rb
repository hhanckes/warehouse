require 'test_helper'

class StorageItemsControllerTest < ActionController::TestCase
  setup do
    @storage_item = storage_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:storage_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create storage_item" do
    assert_difference('StorageItem.count') do
      post :create, storage_item: { capacity: @storage_item.capacity, capacity_measure: @storage_item.capacity_measure, depth: @storage_item.depth, description: @storage_item.description, dimensions_measure: @storage_item.dimensions_measure, height: @storage_item.height, name: @storage_item.name, price: @storage_item.price, width: @storage_item.width }
    end

    assert_redirected_to storage_item_path(assigns(:storage_item))
  end

  test "should show storage_item" do
    get :show, id: @storage_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @storage_item
    assert_response :success
  end

  test "should update storage_item" do
    patch :update, id: @storage_item, storage_item: { capacity: @storage_item.capacity, capacity_measure: @storage_item.capacity_measure, depth: @storage_item.depth, description: @storage_item.description, dimensions_measure: @storage_item.dimensions_measure, height: @storage_item.height, name: @storage_item.name, price: @storage_item.price, width: @storage_item.width }
    assert_redirected_to storage_item_path(assigns(:storage_item))
  end

  test "should destroy storage_item" do
    assert_difference('StorageItem.count', -1) do
      delete :destroy, id: @storage_item
    end

    assert_redirected_to storage_items_path
  end
end
