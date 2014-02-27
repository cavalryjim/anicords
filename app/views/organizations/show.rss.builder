xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title @organization.name
    xml.description "Notifications"
    xml.link @organization

    @notifications.each do |notification|
      xml.item do
        xml.title notification.name
        xml.description article.content
        xml.pubDate article.published_at.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
      end
    end
  end
end