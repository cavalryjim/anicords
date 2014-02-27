xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title @organization.name
    xml.description "Notifications"
    xml.link @organization

    @notifications.each do |notification|
      xml.item do
        xml.title notification.animal.name if notification.animal.present?
        xml.description notification.message
        xml.pubDate notification.updated_at.to_s(:rfc822)
        xml.link notification.url
        xml.guid notification.id
      end
    end
  end
end