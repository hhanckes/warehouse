require 'test_helper'

class StorageItemReturnProofsControllerTest < ActionController::TestCase
  setup do
    @storage_item_return_proof = storage_item_return_proofs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:storage_item_return_proofs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create storage_item_return_proof" do
    assert_difference('StorageItemReturnProof.count') do
      post :create, storage_item_return_proof: { comments: @storage_item_return_proof.comments }
    end

    assert_redirected_to storage_item_return_proof_path(assigns(:storage_item_return_proof))
  end

  test "should show storage_item_return_proof" do
    get :show, id: @storage_item_return_proof
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @storage_item_return_proof
    assert_response :success
  end

  test "should update storage_item_return_proof" do
    patch :update, id: @storage_item_return_proof, storage_item_return_proof: { comments: @storage_item_return_proof.comments }
    assert_redirected_to storage_item_return_proof_path(assigns(:storage_item_return_proof))
  end

  test "should destroy storage_item_return_proof" do
    assert_difference('StorageItemReturnProof.count', -1) do
      delete :destroy, id: @storage_item_return_proof
    end

    assert_redirected_to storage_item_return_proofs_path
  end
end
