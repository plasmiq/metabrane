class ResonanceCoreController < ApplicationController
  skip_before_filter :authentication_check

  before_filter :verify_params, :except => ['highscore', 'get_entry_point']

  def get_entry_point
    node = NodeDeposit.new
    weave = WorkingPair.find_by_id(params[:weave_id])
    substrate = Substrate.find_by_id(params[:substrate_id])
    if weave.blank? or substrate.blank?
      weave = WorkingPair.random
      substrate = weave.random_substrate
    end

    if substrate
      #SAVE START TRAVEL TO NODE DEPOSIT
      NodeDeposit.create(
        :session => params["user_session_id"],
        :pivot => 0,
        :substrate_id => substrate.id,
        :working_pair_id => weave.id
      )

      url = substrate.image.url(:ultra_poster)     
      render :text => {
        :url => "http://" + request.host_with_port + url,
        :metatags => node.metatags
      }.to_json
    else
      render :text => {:error => "something went wrong"}.to_json
    end
  end
 
  def bind
    pivot = params["click_area"].to_i
    
    #LOOK IN THE PAST TO FIND HISTORY
    node = NodeDeposit.find_last_by_session(params["user_session_id"]) || NodeDeposit.new
    
    #ENTRY POINT
    weave = node.working_pair || WorkingPair.random 
    substrate = node.substrate || weave.random_substrate
    
    unless node.new_record?
      case pivot
        when 1
          weave = weave.travel_past(-1)
        when 2
          weave = weave.newer_metatags.first
        when 3
          weave = weave.travel_future(1)
        when 4
          weave = weave.travel_past(-1)
        when 5
          weave =  nil
        when 6
          weave = weave.travel_future(1)
        when 7
          weave = weave.travel_past(-1)
        when 8
          weave = weave.older_metatags.first 
        when 9
          weave = weave.travel_future(1) 
        else 
      end
    end
    
    #JUMP SOMEWHERE IF NOTHING AHEAD
    weave = WorkingPair.random unless weave
    substrate = weave.random_substrate
    
    if substrate
      #SAVE TRAVEL TO NODE DEPOSIT
      NodeDeposit.create  :session => params["user_session_id"],
                          :pivot => pivot,
                          :substrate_id => substrate.id,
                          :working_pair_id => weave.id#,
                          #:clicked_at => Date.new( params["clicked_at"]  )
      
      
      url = substrate.image.url(:ultra_poster)     
      render :text => {
        :url => "http://" + request.host_with_port + url,
        :metatags => node.metatags
      }.to_json
    else
      render :text => {:error => "something went wrong"}.to_json
    end
  end
  
  def highscore
    current_travel = NodeDeposit.where(:session => params[:user_session_id]).order(:created_at)
    count = NodeDeposit.group(:session).count(:order => "count_all DESC")
    position = 0
    count.each.with_index do |x, i|
      if x[0].eql?(params[:user_session_id])
        position = (i + 1)
        break
      end
    end
    render :text => {
        :highscore => count.map {|x| 
          {
            :session_id => x[0],
            :count => x[1],
            :time => NodeDeposit.where(:session => x[0]).order(:created_at).last.created_at.to_i -
              NodeDeposit.where(:session => x[0]).order(:created_at).first.created_at.to_i
          }
        },
        :current => {
          :session_id => params[:user_session_id],
          :score => current_travel.size,
          :time => current_travel.last.created_at.to_i - current_travel.first.created_at.to_i,
          :position => position
        }
      }.to_json
  end
  
private

  def verify_params 
    raise "invalid session id" unless params["user_session_id"]
    raise "click area not provided" unless params["click_area"]
    raise "click time not provided" unless params["clicked_at"]
  rescue => e
    render :text => {:error => "not this time lad..", :exception => e.inspect}.to_json
  end

end
