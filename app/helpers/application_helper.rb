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
        image_tag(s3_url('petabyt_icon.ico'), size: size, id: 'animal'+animal.id.to_s, class: image_classes(animal, classes, view_section) )
      end
    end
    
  end
  
  def image_classes(animal, classes, view_section)
    return '' if classes == 'none'
    classes << ' transfer' if animal.pending_transfer? 
    classes << ' animal_alert' if ((view_section == 'Household' || 'Organization') && (animal.has_notifications?)) # JDavis: add this if animal has alerts
    return classes
  end
  
  def petabyt_image
    image_tag(s3_url('petabyt_f.png'), size: '120x120', class: 'petabyt_image')
  end
  
  def link_to_home
    if current_user && current_user.no_associations?
     link_to(petabyt_image, user_select_account_type_path)
    elsif current_user 
     link_to(petabyt_image, user_select_association_path ) 
    else 
     link_to(petabyt_image, new_user_registration_path + "#" )
    end
  end
  
  def s3_url(file_name)
    #'https://s3-us-west-2.amazonaws.com/petabyt/app_images/' << file_name
    'https://s3.amazonaws.com/petabyt/app_images/' << file_name
  end
  
  def button_small(text, button_id = 'button1', button_class = '' )
    ("<button class='small "+button_class+"' id="+"'"+button_id+"'"+">"+text+"</button>").html_safe
  end
  
  #def fun_button_small(text)
  #  ("<button class='small round fun_font'>"+text+"</button>").html_safe
  #end
  
  #def fun_button_tiny(text)
  #  ("<button class='tiny round fun_font'>"+text+"</button>").html_safe
  #end
  
  def number_of_notifications
    user_notifications.count > 0 ? user_notifications.count : false
  end
  
  def user_notifications
    user_notifications = current_user.all_notifications
    current_user.user_associations.where(receive_notifications: true, group_type: "Organization").each do |ua|
      user_notifications << Notification.new(message: ua.name + " has notifications", url: organization_path(ua.group) ) if ua.group.notifications.count > 0
    end
    return user_notifications
    
    #if number_of_notifications > 0 
    #  html = ""
    #  current_user.all_notifications.each do |n|
    #    html = html + "<li>" + link_to_if(basic_notification_url(n).present?, basic_notification(n), basic_notification_url(n)) + "</li>"
    #  end
    #  current_user.user_associations.where(receive_notifications: true, group_type: "Organization").each do |m|
    #    html = html + "<li>" + link_to(m.name + " has notifications", m.group) + "</li>" if m.group.notifications.count > 0 
    #  end
    #else
    #  html = "<li>" + link_to('No alerts', '#') + "</li>"
    #end 
  end
  
  def notifications_list
    html = "<ul class='dropdown'>"
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
  
  def breadcrumb_nav(crumbs)
    breadcrumb = '<nav id="breadcrumb_nav" class="breadcrumbs">'
    breadcrumb << link_to('HOME', user_select_association_path) unless crumbs.last == 'home'
    crumbs.each do |crumb|
      breadcrumb << ((crumb == crumbs.last) ? link_to(crumb, "#", {class: 'current'}) : link_to(crumb, crumb))
    end
    breadcrumb << '</nav>'
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
  
#### JDavis: let the privacy policy be the last item in this helper ####
  
  def privacy_policy_text
    %q[
This Privacy Policy governs the manner in which Dooliddl Labs  collects, uses, maintains and discloses information collected from users (each, a "User") of the <a href="petabyt.com">petabyt.com</a> website ("Site"). This privacy policy applies to the Site and all products and services offered by Dooliddl Labs .<br><br>

<b>Personal identification information</b><br><br>

We may collect personal identification information from Users in a variety of ways, including, but not limited to, when Users visit our site, register on the site, fill out a form, and in connection with other activities, services, features or resources we make available on our Site. Users may be asked for, as appropriate, name, email address, mailing address, phone number. We will collect personal identification information from Users only if they voluntarily submit such information to us. Users can always refuse to supply personally identification information, except that it may prevent them from engaging in certain Site related activities.<br><br>

<b>Non-personal identification information</b><br><br>

We may collect non-personal identification information about Users whenever they interact with our Site. Non-personal identification information may include the browser name, the type of computer and technical information about Users means of connection to our Site, such as the operating system and the Internet service providers utilized and other similar information.<br><br>

<b>Web browser cookies</b><br><br>

Our Site may use "cookies" to enhance User experience. User's web browser places cookies on their hard drive for record-keeping purposes and sometimes to track information about them. User may choose to set their web browser to refuse cookies, or to alert you when cookies are being sent. If they do so, note that some parts of the Site may not function properly.<br><br>

<b>How we use collected information</b><br><br>

Dooliddl Labs  may collect and use Users personal information for the following purposes:<br>
<ul>
<li><i>- To improve customer service</i><br>
  Information you provide helps us respond to your customer service requests and support needs more efficiently.</li>
<li><i>- To personalize user experience</i><br>
  We may use information in the aggregate to understand how our Users as a group use the services and resources provided on our Site.</li>
<li><i>- To improve our Site</i><br>
  We may use feedback you provide to improve our products and services.</li>
<li><i>- To process payments</i><br>
  We may use the information Users provide about themselves when placing an order only to provide service to that order. We do not share this information with outside parties except to the extent necessary to provide the service.</li>
<li><i>- To run a promotion, contest, survey or other Site feature</i><br>
  To send Users information they agreed to receive about topics we think will be of interest to them.</li>
<li><i>- To send periodic emails</i><br>
We may use the email address to send User information and updates pertaining to their order. It may also be used to respond to their inquiries, questions, and/or other requests. If User decides to opt-in to our mailing list, they will receive emails that may include company news, updates, related product or service information, etc. If at any time the User would like to unsubscribe from receiving future emails, we include detailed unsubscribe instructions at the bottom of each email or User may contact us via our Site.</li>
</ul>
<b>How we protect your information</b><br><br>

We adopt appropriate data collection, storage and processing practices and security measures to protect against unauthorized access, alteration, disclosure or destruction of your personal information, username, password, transaction information and data stored on our Site.<br><br>

Sensitive and private data exchange between the Site and its Users happens over a SSL secured communication channel and is encrypted and protected with digital signatures.<br><br>

<b>Sharing your personal information</b><br><br>

We do not sell, trade, or rent Users personal identification information to others. We may share generic aggregated demographic information not linked to any personal identification information regarding visitors and users with our business partners, trusted affiliates and advertisers for the purposes outlined above.We may use third party service providers to help us operate our business and the Site or administer activities on our behalf, such as sending out newsletters or surveys. We may share your information with these third parties for those limited purposes provided that you have given us your permission.<br><br>

<b>Third party websites</b><br><br>

Users may find advertising or other content on our Site that link to the sites and services of our partners, suppliers, advertisers, sponsors, licensors and other third parties. We do not control the content or links that appear on these sites and are not responsible for the practices employed by websites linked to or from our Site. In addition, these sites or services, including their content and links, may be constantly changing. These sites and services may have their own privacy policies and customer service policies. Browsing and interaction on any other website, including websites which have a link to our Site, is subject to that website's own terms and policies.<br><br>

<b>Advertising</b><br><br>

Ads appearing on our site may be delivered to Users by advertising partners, who may set cookies. These cookies allow the ad server to recognize your computer each time they send you an online advertisement to compile non personal identification information about you or others who use your computer. This information allows ad networks to, among other things, deliver targeted advertisements that they believe will be of most interest to you. This privacy policy does not cover the use of cookies by any advertisers.<br><br>

<b>Changes to this privacy policy</b><br><br>

Dooliddl Labs  has the discretion to update this privacy policy at any time. When we do, we will post a notification on the main page of our Site, revise the updated date at the bottom of this page. We encourage Users to frequently check this page for any changes to stay informed about how we are helping to protect the personal information we collect. You acknowledge and agree that it is your responsibility to review this privacy policy periodically and become aware of modifications.<br><br>

<b>Your acceptance of these terms</b><br><br>

By using this Site, you signify your acceptance of this policy. If you do not agree to this policy, please do not use our Site. Your continued use of the Site following the posting of changes to this policy will be deemed your acceptance of those changes.<br><br>

<b>Contacting us</b><br><br>

If you have any questions about this Privacy Policy, the practices of this site, or your dealings with this site, please contact us at:<br>
<a href="petabyt.com">Dooliddl Labs </a><br>
<a href="petabyt.com">petabyt.com</a><br>
281.787.4362<br>
tyler@petabyt.com<br>
<br>
This document was last updated on May 08, 2014<br><br>

<div style="font-size:10px;color:gray;">Privacy policy created by <a style="font-size:10px;color:gray;text-decoration:none;cursor:default;" href="http://www.generateprivacypolicy.com" target="_blank">Generate Privacy Policy</a></div>

    ]
  end
  
end
