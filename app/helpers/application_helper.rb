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
  
  def thumbnail(animal, size = '100x100', classes = 'th', view_section = nil )
    #return image_tag(animal.avatar.url, size: avatar_size, id: 'animal'+animal.id.to_s, class: image_classes(animal) ) if animal.avatar_stored?
    if animal.avatar.present?
      image_tag(animal.avatar.url, size: size, id: 'animal'+animal.id.to_s, class: image_classes(animal, classes, view_section) )
    elsif animal.org_profile && animal.org_profile.thumbnail_url.present?
      image_tag(animal.org_profile.thumbnail_url, size: size, id: 'animal'+animal.id.to_s, class: image_classes(animal, classes, view_section) )
    else 
      #s3_url('petabyt_icon.ico')  
      case animal.species
      when 'dog'
        image_tag(s3_url('dog_icon.png'), size: size, id: 'animal'+animal.id.to_s, class: image_classes(animal, classes, view_section) )
      when 'cat'
        image_tag(s3_url('cat_icon.png'), size: size, id: 'animal'+animal.id.to_s, class: image_classes(animal, classes, view_section) )
      when 'horse'
        image_tag(s3_url('horse_icon.png'), size: size, id: 'animal'+animal.id.to_s, class: image_classes(animal, classes, view_section) )
      when'tiger'
        image_tag(s3_url('tiger_icon.png'), size: size, id: 'animal'+animal.id.to_s, class: image_classes(animal, classes, view_section) )
      else
        image_tag(s3_url('animalminder.ico'), size: size, id: 'animal'+animal.id.to_s, class: image_classes(animal, classes, view_section) )
      end
    end
    
  end
  
  def image_classes(animal, classes, view_section)
    return '' if classes == 'none'
    return 'th' if classes == 'th_only'
    classes << ' transfer' if animal.pending_transfer? 
    classes << ' animal_alert' if ((view_section == 'Household' || view_section == 'Organization') && (animal.has_notifications?)) # JDavis: add this if animal has alerts
    return classes
  end
  
  def animalminder_image
    #image_tag(s3_url('petabyt_f.png'), size: '120x120', class: 'petabyt_image')
    image_tag(s3_url('animal_minder2.png'), size: '220x220', class: 'animalminder_image')
  end
  
  def link_to_home(anchor = animalminder_image)
    if current_user && current_user.no_associations?
     link_to(anchor, user_select_account_type_path)
    elsif current_user 
     link_to(anchor, user_select_association_path ) 
    else 
     link_to(anchor, new_user_registration_path + "#" )
    end
  end

  def s3_url(file_name)
    #'https://s3-us-west-2.amazonaws.com/petabyt/app_images/' << file_name
    #'https://s3.amazonaws.com/petabyt/app_images/' << file_name
    'https://s3.amazonaws.com/animal_minder/app_images/' << file_name
  end
  
  def button_small(text, button_id = 'button1', button_class = '' )
    ("<button class='small "+button_class+"' id="+"'"+button_id+"'"+">"+text+"</button>").html_safe
  end
  
  def number_of_notifications
    user_notifications.count > 0 ? user_notifications.count : false
  end
  
  def user_notifications
    user_notifications = current_user.all_notifications
    current_user.user_associations.where(receive_notifications: true, group_type: "Organization").each do |ua|
      user_notifications << Notification.new(message: ua.name + " has notifications", url: organization_path(ua.group) ) if ua.group.notifications.count > 0
    end
    return user_notifications
  end
  
  def notifications_list
    html = "<ul id='notifications_drop' class='f-dropdown' data-dropdown-content>"
    if user_notifications.count > 0
      user_notifications.each do |n|
        html += "<li>" + link_to_if(basic_notification_url(n).present?, basic_notification(n), basic_notification_url(n)) + "</li>"
      end
    else
      html += "<li>" + link_to('No alerts', '#') + "</li>"
    end 
    html += "</ul>"
    return html
  end
  
  def file_types
    ['vaccination', 'rabies', 'veterinary', 'other']
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
  
  def wt_options
    ["lbs", "kg"]
  end
  
  def size_options
    ["small", "medium", "large"]
  end
  
  def test_result_options
    [['pos', true], ['neg', false]]
  end
  
  def medication_routes
    options_for_select(["topical", "oral", "injection"])
  end
  
  def medication_intervals
    options_for_select(["daily", "2 x daily", "3 x daily", "4 x daily", "weekly", "monthly", "other"])
  end
  
  def breadcrumb_nav(crumbs = ['Health management platform for animals'] )
    breadcrumb = ' <div class="breadcrumb right"> '
    #breadcrumb << ((crumbs.last == 'Home') ? 'Home' : link_to('Home', user_select_association_path) if current_user.present? )
    crumbs.each do |crumb|
      break if crumb == 'Home'
      #breadcrumb << ((crumb == crumbs.last) ? link_to(crumb, "#", {class: 'current'}) : link_to(crumb, crumb))
      #breadcrumb << crumb 
      breadcrumb << ' &nbsp;|&nbsp; ' unless (crumb == crumbs.first)
      breadcrumb << crumb if crumb.present?
      #breadcrumb << ' &nbsp;|&nbsp; ' unless (crumb == crumbs.last)
    end
    breadcrumb << '</div>'
    breadcrumb.html_safe
  end
  
  def suggested_household_name(user)
    if user.last_name.present?
      user.last_name + " household" 
    elsif user.first_name.present?
      user.first_name + " household" 
    else
      user.email.split('@').first + " household"
    end
  end
  
  def basic_notification(notification)
    if notification.animal.present?
      notification.animal.name + ": " + notification.message
    else 
      notification.message
    end
  end
  
  def basic_notification_url(notification)
    if notification.url.present?
      return notification.url
    elsif notification.animal.present?
      return polymorphic_path([:edit, notification.animal.owner, notification.animal])
    else
      return nil
    end
  end
  
  def display_roles(user, entity)
    roles = user.roles.where(resource: entity)
    roles.map{|r| r.name}.join(", ")
  end
  
#### JDavis: let the states be the second to last item in this helper ####
  
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
  
  
end
