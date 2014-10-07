require 'test_helper'

class InformationPagesControllerTest < ActionController::TestCase
  setup do
    @information_page = information_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:information_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create information_page" do
    assert_difference('InformationPage.count') do
      post :create, information_page: { subtitle: @information_page.subtitle, title: @information_page.title }
    end

    assert_redirected_to information_page_path(assigns(:information_page))
  end

  test "should show information_page" do
    get :show, id: @information_page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @information_page
    assert_response :success
  end

  test "should update information_page" do
    patch :update, id: @information_page, information_page: { subtitle: @information_page.subtitle, title: @information_page.title }
    assert_redirected_to information_page_path(assigns(:information_page))
  end

  test "should destroy information_page" do
    assert_difference('InformationPage.count', -1) do
      delete :destroy, id: @information_page
    end

    assert_redirected_to information_pages_path
  end
end
