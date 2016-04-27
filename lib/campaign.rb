class Cms
  def log_data
    count = 0
    File.open("lib/votes.txt", "r") do |f|
      while line = f.gets
        line_arr = line.force_encoding("ISO-8859-1").encode("utf-8", replace: nil).strip.split(" ") if line
        if line_arr
          campaign_name = candidate_name = validity = guid = nil
          line_arr.each do |val|
            campaign_name = val.split(":")[1] if val.split(":")[0] == "Campaign"
            candidate_name = val.split(":")[1] if val.split(":")[0] == "Choice"
            validity = val.split(":")[1] if val.split(":")[0] == "Validity"
            guid = val.split(":")[1] if val.split(":")[0] == "GUID"
          end
          vote = Vote.find_by_campaign_name_and_guid(campaign_name, guid)
          if campaign_name and guid
            new_vote = Vote.create!(:campaign_name => campaign_name, :candidate_name => candidate_name, :validity => validity, :guid => guid) if !vote
            #puts "vote created successfully #{new_vote}"
          end
          count = count + 1
          puts "count #{count}"
        end
      end      
    end
  #Vote.import votes
  end
end
app = Cms.new
app.log_data
