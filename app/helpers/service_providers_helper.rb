module ServiceProvidersHelper
  
  def service_selected(service_provider, service_id)
    service_provider ? (service_provider.service_ids.include? service_id) : nil
  end
  
  def business_selected(service_provider, service_type_id)
    service_provider ? (service_provider.service_provider_type_ids.include? service_type_id) : nil
  end
  
  def link_to_add_veterinarian_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('service_providers/veterinarian_fields', f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def hide_veterinarians(service_provider)
    'hidden' if !(service_provider && service_provider.is_veterinarian?)
  end
  
  def provider_row_classes(checked_in)
    checked_in ? "current_client" : " "
  end
    
  
end
