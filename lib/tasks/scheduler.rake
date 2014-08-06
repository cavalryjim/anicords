desc "These tasks are called by the Heroku scheduler add-on"

task :work_queued_jobs => :environment do
  jobs = QC.count
  puts jobs > 0 ? "Sending emails" : "No queued emails"
  
  if QC.count > 0 
    w = QC::Worker.new 
    w.work until QC.count == 0
  end
  
  puts "Done sending #{jobs} emails"
end

task :animals_needing_org_profile => :environment do
  if Animal.without_org_profile.count > 0 
    UserMailer.animals_without_org_profile.deliver
  else
    puts "No animals needing an org_profile."
  end
end

task :create_vaccination_notifications => :environment do
  num = AnimalVaccination.create_vaccination_notifications
  puts "Sent #{num} vaccination notifications"
end

task :orphan_associations => :environment do
  if UserAssociation.orphan_associations.count > 0 
    UserMailer.orphan_associations.deliver
  else
    puts "No orphaned associations, yeah!"
  end
end

task :weekly_usage => :environment do
  if Date.today.sunday?
    stat = UsageStatistic.new
    stat.usage_snapshot
    stat.save
    UserMailer.weekly_usage_snapshot.deliver
  end 
end

