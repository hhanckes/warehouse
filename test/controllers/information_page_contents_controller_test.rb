require 'test_helper'

class InformationPageContentsControllerTest < ActionController::TestCase
  setup do
    @information_page_content = information_page_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:information_page_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create information_page_content" do
    assert_difference('InformationPageContent.count') do
      post :create, information_page_content: { content: @information_page_content.content, information_page_id: @information_page_content.information_page_id, subtitle: @information_page_content.subtitle, title: @information_page_content.title }
    end

    assert_redirected_to information_page_content_path(assigns(:information_page_content))
  end

  test "should show information_page_content" do
    get :show, id: @information_page_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @information_page_content
    assert_response :success
  end

  test "should update information_page_content" do
    patch :update, id: @information_page_content, information_page_content: { content: @information_page_content.content, information_page_id: @information_page_content.information_page_id, subtitle: @information_page_content.subtitle, title: @information_page_content.title }
    assert_redirected_to information_page_content_path(assigns(:information_page_content))
  end

  test "should destroy information_page_content" do
    assert_difference('InformationPageContent.count', -1) do
      delete :destroy, id: @information_page_content
    end

    assert_redirected_to information_page_contents_path
  end
end
