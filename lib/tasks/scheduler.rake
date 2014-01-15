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

