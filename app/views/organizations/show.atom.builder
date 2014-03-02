atom_feed do |feed|
  feed.title @organization.name
  feed.updated @notifications.maximum(:updated_at)
  
  @notifications.each do |notification|
    feed.entry notification, published: notification.updated_at, url: notification.url do |entry|
      entry.title notification.animal.present? ? (notification.animal.name + ' ' + notification.message) : notification.message
      #entry.content article.content
      #entry.author "James"
    end
  end
end
