class WeavesController < ApplicationController
  def create
    wp = WorkingPair.new(params[:working_pair])
    wp.save  
    redirect_to :controller => :timeline
  end

end
