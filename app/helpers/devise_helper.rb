module DeviseHelper
  def devise_error_messages!
    return "" if (defined?(resource)).nil? || resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert-box alert" data-alert>
       #{messages}
      <a href="" class="close">&times;</a>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end
  
  def omniauth_verbage(provider)
    if provider.to_s.titleize == "Facebook"
     ( " or use " + image_tag(s3_url('webicon-facebook-m.png'), class: 'selectable_image')).html_safe
    else    
      "Login with #{provider.to_s.titleize}"
    end
  end

end