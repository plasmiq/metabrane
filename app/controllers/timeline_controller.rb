class TimelineController < ApplicationController
  
  def index 
    @pairs = WorkingPair.find(:all,:order => "created_at desc")
  end
  
  
end
