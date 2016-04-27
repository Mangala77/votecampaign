class VotesController < ApplicationController
  
  def index
    @votes = Vote.group(:campaign_name).where.not(:validity => nil, :candidate_name => nil)
    @compaigns = @votes.map{|x| x.campaign_name} if @votes
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @compaigns }
    end
  end

  def list_candidates
    if params[:name]
      @candidate_details = []
      candidate_list = Vote.where(campaign_name: params[:name]).group(:candidate_name).map{|cd| cd.candidate_name}
      if candidate_list
        candidate_list.each do |cd|
          @cd_list = {}
          @cd_list["score"] = @cd_list["wrong_score"] = 0
          @cd_list["name"] = cd
          ## checking with validity during to count the candidate score
          result_with_score = Vote.where(campaign_name: params[:name], validity: "during", :candidate_name => cd).count
          @cd_list["score"] = result_with_score if result_with_score
          ## check for pre and post message on validity to define wrong score for candidate
          result_with_invalid_score = Vote.where(campaign_name: params[:name], :candidate_name => cd).where.not(validity: "during").count
          @cd_list["wrong_score"] = result_with_invalid_score if result_with_invalid_score
          @candidate_details << @cd_list
        end
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @candidate_details }
    end
  end
end