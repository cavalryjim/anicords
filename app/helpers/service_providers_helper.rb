module ServiceProvidersHelper
  
  def service_selected(service_provider, service_id)
    service_provider ? (service_provider.service_ids.include? service_id) : nil

  end
  
end
