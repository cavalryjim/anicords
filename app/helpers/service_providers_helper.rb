module ServiceProvidersHelper
  
  def service_selected(service_provider, service_id)
    service_provider ? (service_provider.service_ids.include? service_id) : nil
  end
  
  def business_selected(service_provider, service_type_id)
    service_provider ? (service_provider.service_provider_type_ids.include? service_type_id) : nil
  end
  
end
