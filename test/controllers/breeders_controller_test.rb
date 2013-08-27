require 'test_helper'

class BreedersControllerTest < ActionController::TestCase
  setup do
    @breeder = breeders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:breeders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create breeder" do
    assert_difference('Breeder.count') do
      post :create, breeder: { address1: @breeder.address1, address2: @breeder.address2, city: @breeder.city, email: @breeder.email, name: @breeder.name, phone: @breeder.phone, state: @breeder.state, website: @breeder.website, zip: @breeder.zip }
    end

    assert_redirected_to breeder_path(assigns(:breeder))
  end

  test "should show breeder" do
    get :show, id: @breeder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @breeder
    assert_response :success
  end

  test "should update breeder" do
    patch :update, id: @breeder, breeder: { address1: @breeder.address1, address2: @breeder.address2, city: @breeder.city, email: @breeder.email, name: @breeder.name, phone: @breeder.phone, state: @breeder.state, website: @breeder.website, zip: @breeder.zip }
    assert_redirected_to breeder_path(assigns(:breeder))
  end

  test "should destroy breeder" do
    assert_difference('Breeder.count', -1) do
      delete :destroy, id: @breeder
    end

    assert_redirected_to breeders_path
  end
end
