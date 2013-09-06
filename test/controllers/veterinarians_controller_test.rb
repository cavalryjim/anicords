require 'test_helper'

class VeterinariansControllerTest < ActionController::TestCase
  setup do
    @veterinarian = veterinarians(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:veterinarians)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create veterinarian" do
    assert_difference('Veterinarian.count') do
      post :create, veterinarian: { address1: @veterinarian.address1, address2: @veterinarian.address2, city: @veterinarian.city, clinic_name: @veterinarian.clinic_name, email: @veterinarian.email, phone: @veterinarian.phone, state: @veterinarian.state, zip: @veterinarian.zip }
    end

    assert_redirected_to veterinarian_path(assigns(:veterinarian))
  end

  test "should show veterinarian" do
    get :show, id: @veterinarian
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @veterinarian
    assert_response :success
  end

  test "should update veterinarian" do
    patch :update, id: @veterinarian, veterinarian: { address1: @veterinarian.address1, address2: @veterinarian.address2, city: @veterinarian.city, clinic_name: @veterinarian.clinic_name, email: @veterinarian.email, phone: @veterinarian.phone, state: @veterinarian.state, zip: @veterinarian.zip }
    assert_redirected_to veterinarian_path(assigns(:veterinarian))
  end

  test "should destroy veterinarian" do
    assert_difference('Veterinarian.count', -1) do
      delete :destroy, id: @veterinarian
    end

    assert_redirected_to veterinarians_path
  end
end
