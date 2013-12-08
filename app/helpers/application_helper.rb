module ApplicationHelper
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")} )
  end
  
  def mo_da_yr(d)
    d.strftime("%m/%d/%Y") if d
  end
  
  def dooliddl_image
    image_tag('dooliddl_f.png', size: '300x300')
  end
  
  def link_to_home
    if session[:home_page]
     link_to(dooliddl_image, session[:home_page])
    elsif current_user && current_user.no_associations?
     link_to(dooliddl_image, user_select_account_type_path)
    elsif current_user && current_user.user_associations.count == 1
     link_to(dooliddl_image, current_user.user_associations.first.organization ) 
    else 
     dooliddl_image 
    end
  end
  
  def user_notifications
    if current_user.has_notifications?
      html = ""
      current_user.notifications.each do |n|
        #JDavis: need to add the notification.id to the path.
        html = html + "<li>" + link_to(n.message, n.url+"?notice="+n.id.to_s) + "</li>"
      end
    else
      html = "<li>" + link_to('No alerts', '#') + "</li>"
    end
    
    return html
    #html.html_safe
  end
  
  def us_states
    [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]
  end
  
  #JDavis: cancan link helpers
  def show_link(object, content = "Show")
    link_to(content, object) if can?(:read, object)
  end
  
  def edit_link(object, content = "Edit")
    link_to(content, [:edit, object]) if can?(:update, object)
  end
  
  def destroy_link(object, content = "Destroy")
    link_to(content, object, :method => :delete, :confirm => "Are you sure?") if can?(:destroy, object)
  end
  
  def create_link(object, content = "New")
    if can?(:create, object)
      object_class = (object.kind_of?(Class) ? object : object.class)
      link_to(content, [:new, object_class.name.underscore.to_sym])
    end
  end
  
end
