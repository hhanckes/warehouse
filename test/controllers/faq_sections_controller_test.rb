require 'test_helper'

class FaqSectionsControllerTest < ActionController::TestCase
  setup do
    @faq_section = faq_sections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:faq_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create faq_section" do
    assert_difference('FaqSection.count') do
      post :create, faq_section: { description: @faq_section.description, name: @faq_section.name }
    end

    assert_redirected_to faq_section_path(assigns(:faq_section))
  end

  test "should show faq_section" do
    get :show, id: @faq_section
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @faq_section
    assert_response :success
  end

  test "should update faq_section" do
    patch :update, id: @faq_section, faq_section: { description: @faq_section.description, name: @faq_section.name }
    assert_redirected_to faq_section_path(assigns(:faq_section))
  end

  test "should destroy faq_section" do
    assert_difference('FaqSection.count', -1) do
      delete :destroy, id: @faq_section
    end

    assert_redirected_to faq_sections_path
  end
end
