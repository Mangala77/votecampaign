begin 
  task 'import:campaign' do
    cmd = 'bundle exec rails runner "eval(File.read \'lib/campaign.rb\')";'; 
    puts cmd;
    system cmd
  end
  
end

