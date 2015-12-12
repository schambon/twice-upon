namespace :bootstrap do
  desc "Add default user and counter"
  task :default_data => :environment do
    u = User.create( :id => 1, :name => 'default')
    Counter.create( :id => 1, :name => 'default', :user => u, :cooldown => 15)
  end
end
