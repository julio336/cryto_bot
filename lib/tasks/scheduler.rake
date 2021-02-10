namespace :scheduled_tasks do
  desc "Sync with some source"
  task update: :environment do
    count = 0
    puts "There are x number of things to update"
    
    puts "done."
  end
  desc "Check if can update more..?"
    task poll: :environment do
      puts "Number of Things not yet completed is"
  end
  task :mailme => :environment do
    ApplicationMailer.test_email.deliver
  end
end

