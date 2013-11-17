ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
       column do
         panel "Newest Users" do
           ul do
             User.last(5).map do |user|
               li link_to(user.name_or_email, admin_user_path(user))
             end
           end
         end
       end
       
       column do
         panel "Newest Households" do
           ul do
             Household.last(5).map do |household|
               li link_to(household, admin_household_path(household))
             end
           end
         end
       end
       
       column do
         panel "Newest Providers" do
           ul do
             ServiceProvider.last(5).map do |provider|
               li link_to(provider, admin_service_provider_path(provider))
             end
           end
         end
       end
    

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    end
  end # content
end
