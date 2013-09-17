require 'test_helper'

class ServiceProvidersControllerTest < ActionController::TestCase
  setup do
    @service_provider = service_providers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_providers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_provider" do
    assert_difference('ServiceProvider.count') do
      post :create, service_provider: { address1: @service_provider.address1, address2: @service_provider.address2, city: @service_provider.city, email: @service_provider.email, name: @service_provider.name, phone: @service_provider.phone, state: @service_provider.state, website: @service_provider.website, zip: @service_provider.zip }
    end

    assert_redirected_to service_provider_path(assigns(:service_provider))
  end

  test "should show service_provider" do
    get :show, id: @service_provider
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_provider
    assert_response :success
  end

  test "should update service_provider" do
    patch :update, id: @service_provider, service_provider: { address1: @service_provider.address1, address2: @service_provider.address2, city: @service_provider.city, email: @service_provider.email, name: @service_provider.name, phone: @service_provider.phone, state: @service_provider.state, website: @service_provider.website, zip: @service_provider.zip }
    assert_redirected_to service_provider_path(assigns(:service_provider))
  end

  test "should destroy service_provider" do
    assert_difference('ServiceProvider.count', -1) do
      delete :destroy, id: @service_provider
    end

    assert_redirected_to service_providers_path
  end
end
