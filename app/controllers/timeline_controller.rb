class TimelineController < ApplicationController
  
  def index 
    @pairs = WorkingPair.recent
  end
  
end
